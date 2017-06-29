//
//  ViewController.m
//  WeatherApp2
//
//  Created by Oleh Busko on 31/05/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "TypeCheck.h"
#import "Reachability.h"
#import "TableViewCell.h"
#import "HourlyDataView.h"
#import "ViewController.h"
#import "WeatherAPIRequest.h"
#import "WeatherAPIRequest.h"
#import <CoreData/CoreData.h>
#import "CityWeatherEntity.h"
#import "WeatherAPIResponse.h"
#import <QuartzCore/QuartzCore.h>
#import "SavedDaysViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#endif

@import GoogleMaps;
@import GooglePlaces;

NSString *const kAPIUrl = @"https://api.darksky.net/forecast/74853c2285b60770158e761b0963632e/";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *currentDay;
@property (weak, nonatomic) IBOutlet UILabel *currentTemperature;
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentDayLowTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherCondition;
@property (weak, nonatomic) IBOutlet UILabel *currentDayHighTempLabel;


@property (copy, nonatomic) NSString *city;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) CLLocation *currentLocation;
@property (strong, nonatomic) WeatherAPIResponse *response;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *savedListButton;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UITableView *frontTableView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchResultsHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *hourlyTemperatureScrollView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) GMSPlacesClient *placesClient;
@property (strong, nonatomic) GMSAutocompleteFilter *filter;
@property (strong, nonatomic) NSMutableArray *resultsArray;
@property (strong, nonatomic) NSTimeZone *currentTimeZone;
@property (strong, nonatomic) NSString *coordinates;
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *celsiusLabel;


@end

@implementation ViewController
    CGRect celsiusFrame;
    CGRect searchResultsFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Google API set up
    self.filter = [[GMSAutocompleteFilter alloc] init];
    self.filter.type = kGMSPlacesAutocompleteTypeFilterCity;
    self.placesClient = [GMSPlacesClient sharedClient];
    self.searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self setUpView];
    [self setDefaultValuesForScrollView];
    
    celsiusFrame = _celsiusLabel.frame;
    searchResultsFrame = _searchResultsTableView.frame;
}

- (void)viewDidAppear:(BOOL)animated {
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) {
        [self createAlertViewWithTitle:@"No connection" andMessage:@"Turn on the Wi-fi or Mobile data" onController:self];
    }else {
        [self getCurrentLocationAndUpdateData];
    }
}

- (IBAction)openSavedList:(id)sender {
    SavedDaysViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedListController"];
    vc.bgImage = self.backgroundImageView.image;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark Search Text field methods

- (void)reloadSearchTableView {
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.searchResultsHeightConstraint.constant = [_resultsArray count] * 44;
        [self.searchResultsTableView reloadData];
//    });
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    [self alphaChangeAnimation:1];
    [self.resultsArray removeAllObjects];
    [self reloadSearchTableView];
    
    return YES;
}

- (void)textFieldDidChange :(UITextField *) textField {
    if(![textField.text isEqualToString:@""]){
        [_placesClient autocompleteQuery:textField.text bounds:nil filter:_filter callback:^(NSArray *results, NSError *error) {
            if (error != nil) {
                return;
            }
            self.resultsArray = (NSMutableArray *)results;
            searchResultsFrame.size.height = [_resultsArray count] * 44;
            
            [self reloadSearchTableView];
            [UIView animateWithDuration:0.5
                             animations:^{
                                 self.searchResultsTableView.frame = CGRectMake(searchResultsFrame.origin.x, searchResultsFrame.origin.y , searchResultsFrame.size.width, searchResultsFrame.size.height);
                             }];
            [self alphaChangeAnimation:0.3];
        }];
    }else {
        [self alphaChangeAnimation:1];
        [self.resultsArray removeAllObjects];
        [self reloadSearchTableView];
    }
}

- (void)alphaChangeAnimation:(double)x {
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.headerView.alpha = x;
                         self.frontTableView.alpha = x;
                         self.hourlyTemperatureScrollView.alpha = x;
    }];
}

#pragma mark View set up and update methods
- (void)setUpView {
    self.navigationView.layer.shadowRadius = 0;
    self.navigationView.layer.shadowOpacity = 0.1;
    self.navigationView.layer.masksToBounds = NO;
    self.navigationView.layer.shadowOffset = CGSizeMake(0, 1);
    
    [self.savedListButton setTitle:@"" forState:UIControlStateNormal];
    [self.savedListButton setImage:[UIImage imageNamed:@"list-icon"] forState:UIControlStateNormal];
    
    self.hourlyTemperatureScrollView.layer.borderWidth = 0.5;
    self.hourlyTemperatureScrollView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backgroundImageView.image = [UIImage imageNamed:@"background-image-day"];
    
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.delegate = self;
    
    self.searchResultsTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.celsiusLabel.hidden = YES;
}

- (void)setDefaultValuesForScrollView {
    [self.hourlyTemperatureScrollView setShowsVerticalScrollIndicator:NO];
    [self.hourlyTemperatureScrollView setShowsHorizontalScrollIndicator:NO];
    [self.hourlyTemperatureScrollView setContentSize:CGSizeMake(60 * 24, _hourlyTemperatureScrollView.frame.size.height)];
}

- (void)reloadInformation {
//    dispatch_async(dispatch_get_main_queue(), ^{
     // ???   [self.frontTableView reloadData];
        [self changeLabelsText];
        
        self.celsiusLabel.hidden = NO;
        NSString *temperatureLabelText = [Utility convertFahrenheitToCelsius:_response.hourData.hourlyEntitiesArray[0].temperature];
        switch (temperatureLabelText.length) {
            case 1:
                celsiusFrame.origin.x = _currentTemperature.frame.origin.x + _currentTemperature.frame.size.width - 40;
                self.celsiusLabel.frame = celsiusFrame;
                break;
            case 2:
                celsiusFrame.origin.x = _currentTemperature.frame.origin.x + _currentTemperature.frame.size.width - 20;
                self.celsiusLabel.frame = celsiusFrame;
                break;
            case 3:
                celsiusFrame.origin.x = _currentTemperature.frame.origin.x + _currentTemperature.frame.size.width;
                self.celsiusLabel.frame = celsiusFrame;
                break;
            default:
                break;
        }
//    });
    [self reloadHourlyScrollView:_response currentTime:YES];
}

- (void)changeLabelsText {
    self.selectedDateLabel.text = @"Today";
    self.currentLocationLabel.text = _city;
    self.currentWeatherCondition.text = _response.hourData.hourlyEntitiesArray[0].summary;
    self.currentDay.text = [Utility getDay:_response.hourData.hourlyEntitiesArray[0].time];
    self.currentTemperature.text = [Utility convertFahrenheitToCelsius:_response.hourData.hourlyEntitiesArray[0].temperature];
    self.currentDayLowTempLabel.text = [Utility convertFahrenheitToCelsius:_response.dayData.dailyEntitiesArray[0].temperatureMin];
    self.currentDayHighTempLabel.text = [Utility convertFahrenheitToCelsius:_response.dayData.dailyEntitiesArray[0].temperatureMax];
}


-(void)reloadHourlyScrollView:(WeatherAPIResponse *)response currentTime:(BOOL) isCurrent {
//    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL isEmpty = ([_hourlyTemperatureScrollView.subviews count] == 0);

        for(int i = 0; i < 24; i++){
            HourlyDataView *hourlyView = isEmpty ? [[HourlyDataView alloc] initWithFrame:CGRectMake(i * 60, 6, 50, 75)]  : _hourlyTemperatureScrollView.subviews[i];
            [hourlyView addData:response.hourData.hourlyEntitiesArray[i] withTimeZone:_currentTimeZone];
            if(i == 0 && isCurrent){
                hourlyView.hourLabel.text = @"Now";
            }
            if(isEmpty) {
               [_hourlyTemperatureScrollView addSubview:hourlyView];
            }
        }
        
//    });
}

- (void)checkIfNight {
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self isNight:_response.dayData.dailyEntitiesArray[0].sunsetTime and:_response.dayData.dailyEntitiesArray[0].sunriseTime timezone:_currentTimeZone]){
            self.backgroundImageView.image = [UIImage imageNamed:@"background-image-night"];
        }else {
            self.backgroundImageView.image = [UIImage imageNamed:@"background-image-day"];
        }
    });
}

#pragma mark LocationManager
- (void)getCurrentLocationAndUpdateData {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [_locationManager requestAlwaysAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.currentLocation = [locations objectAtIndex:0];
    [_locationManager stopUpdatingLocation];

    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray *placemarks, NSError *error){
         if (!(error)){
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             self.city = placemark.locality;
             self.currentTimeZone = placemark.timeZone;
             self.coordinates = [self createStringFromCoordinates:_currentLocation.coordinate];

             WeatherAPIRequest *dataRequest = [[WeatherAPIRequest alloc] init];
             [dataRequest setCoordinates:_coordinates];
             [dataRequest sendRequest:kAPIUrl completionHandler:^(BaseResponse *response, NSError *error) {
                 
                 if (!error) {
                     
                 }else{

                 }
                 
                 self.response = (WeatherAPIResponse *)response;
                 [self reloadInformation];
                 [self checkIfNight];
             }];
         }
         else{
             [self createAlertViewWithTitle:@"Error" andMessage:@"Failed to find location\nTry again" onController:self];
         }
     }];
}

- (NSString *)createStringFromCoordinates:(CLLocationCoordinate2D)coordinates {
    NSNumber *lat = [NSNumber numberWithDouble:coordinates.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:coordinates.longitude];
    
    return [[[@"" stringByAppendingString:[lat stringValue]] stringByAppendingString:@","] stringByAppendingString:[lon stringValue]];
}

#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if([tableView isEqual:_frontTableView]){
//        return ;
//    }else{
//        return ;
//    }
//    
    return [tableView isEqual:_frontTableView] ? [_response.dayData.dailyEntitiesArray count]: [_resultsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:_frontTableView]){
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewcell];
        if(!cell){
            [tableView registerNib:[UINib nibWithNibName:kTableViewcell bundle:nil] forCellReuseIdentifier:kTableViewcell];
            cell = [tableView dequeueReusableCellWithIdentifier:kTableViewcell];
        }
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell initWithData:_response.dayData.dailyEntitiesArray[indexPath.row] andCity:_city];

        if(indexPath.row == 0){
            cell.titleLabel.text = @"Now";
        }
        return cell;
    }else{
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }

        GMSAutocompletePrediction* result = _resultsArray[indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = result.attributedFullText.string;
        
        return cell;
    }
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:_frontTableView]){
        UITableViewRowAction *saveAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Save" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            [self saveDataCell:(TableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath]];
            [tableView setEditing:NO animated:YES];
        }];
        
        saveAction.backgroundColor = [Utility colorFromHexString:@"59D85C"];
        return @[saveAction];
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView isEqual:_searchResultsTableView]){
        [self sendRequestForSelectedLocation:indexPath];
    }else {
        if(_frontTableView.alpha == 1){
            if(indexPath.row == 0){
                [self reloadInformation];
            }else{
                TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                [self sendRequestForSelectedDay:cell];
            }
        }
    }
}

#pragma mark TableView's extra methods
- (void)sendRequestForSelectedLocation:(NSIndexPath *)indexPath {
    [[self view] endEditing:YES];
    GMSAutocompletePrediction* result = _resultsArray[indexPath.row];
    self.searchTextField.text = result.attributedFullText.string;
    
    [_resultsArray removeAllObjects];
    [self alphaChangeAnimation:1];
    [self reloadSearchTableView];
    
    [_placesClient lookUpPlaceID:result.placeID callback:^(GMSPlace *result, NSError *error){
        self.coordinates = [self createStringFromCoordinates:result.coordinate];
        
        WeatherAPIRequest *dataRequest = [[WeatherAPIRequest alloc] init];
        CLLocation * location = [[CLLocation alloc] initWithLatitude:result.coordinate.latitude
                                                           longitude:result.coordinate.longitude];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error == nil && [placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks objectAtIndex:0];
                self.currentTimeZone = placemark.timeZone;
                
                [dataRequest setCoordinates:_coordinates];
                [dataRequest sendRequest:kAPIUrl completionHandler:^(BaseResponse *response, NSError *error) {
                    self.response = (WeatherAPIResponse *)response;
                    self.city = result.name;
                    
                    [self checkIfNight];
                    [self reloadInformation];
                }];
                
            }
        }];
        
    }];
}

- (void)sendRequestForSelectedDay:(TableViewCell *)cell {
    WeatherAPIRequest *dataRequest = [[WeatherAPIRequest alloc] init];
    
    [dataRequest setCoordinates:[[_coordinates stringByAppendingString:@","] stringByAppendingString:[NSString stringWithFormat:@"%@",cell.entity.timeInString]]];
    [dataRequest sendRequest:@"https://api.darksky.net/forecast/74853c2285b60770158e761b0963632e/" completionHandler:^(BaseResponse *response, NSError *error) {
        WeatherAPIResponse *responseObj = (WeatherAPIResponse *)response;
        [self reloadHourlyScrollView:responseObj currentTime:NO];
        [self changeLabelsTextCustom:cell];
    }];
}

- (void)changeLabelsTextCustom:(TableViewCell *)cell {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.selectedDateLabel.text = [Utility formatDateToString:cell.entity.time];
        self.currentDay.text = [Utility getDay:cell.entity.time];
        self.currentDayHighTempLabel.text = [Utility convertFahrenheitToCelsius:cell.entity.temperatureMax];
        self.currentDayLowTempLabel.text = [Utility convertFahrenheitToCelsius:cell.entity.temperatureMin];
        self.currentTemperature.text = [Utility convertFahrenheitToCelsius:cell.entity.temperatureMax];
        self.currentWeatherCondition.text = @"--";
    });
}

#pragma mark CoreData methods
-(void)saveDataCell:(TableViewCell *)cell{
    NSManagedObjectContext *context = [self managedObjectContext];

    if([self checkIfExists:cell]){
        NSManagedObject *newDay = [NSEntityDescription insertNewObjectForEntityForName:@"CityWeather" inManagedObjectContext:context];

        [newDay setValue:_city forKey:@"city"];
        [newDay setValue:cell.entity.time forKey:@"time"];
        [newDay setValue:cell.entity.icon forKey:@"icon"];
        [newDay setValue:cell.entity.summary forKey:@"summary"];
        [newDay setValue:cell.entity.pressure forKey:@"pressure"];
        [newDay setValue:cell.entity.humidity forKey:@"humidity"];
        [newDay setValue:cell.entity.windSpeed forKey:@"windSpeed"];
        [newDay setValue:cell.entity.moonPhase forKey:@"moonPhase"];
        [newDay setValue:cell.entity.visibility forKey:@"visibility"];
        [newDay setValue:cell.entity.sunsetTime forKey:@"sunsetTime"];
        [newDay setValue:cell.entity.windBearing forKey:@"windBearing"];
        [newDay setValue:cell.entity.sunriseTime forKey:@"sunriseTime"];
        [newDay setValue:[Utility convertFahrenheitToCelsius:cell.entity.temperatureMin] forKey:@"lowTemp"];
        [newDay setValue:[Utility convertFahrenheitToCelsius:cell.entity.temperatureMax] forKey:@"highTemp"];

        NSError *error = nil;

        if (![context save:&error]) {
            [self createAlertViewWithTitle:@"Warning" andMessage:@"Could not save\nTry again" onController:self];
        }
         
    }
}

-(BOOL)checkIfExists:(TableViewCell *)cell{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(city = %@) AND (time = %@)", _city, cell.entity.time];
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication]delegate]).persistentContainer.viewContext;
    
    request.predicate = predicate;
    request.entity = [NSEntityDescription entityForName:@"CityWeather" inManagedObjectContext:context];
    
    NSError *error = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error];
    
    if(error){
        return false;
    }else{
        if([objs count] > 0){
            return false;
        }else{
            return true;
        }
    }
}


@end
