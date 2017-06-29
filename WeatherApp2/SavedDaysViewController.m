//
//  SavedDaysViewController.m
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import <CoreData/CoreData.h>
#import "CityWeatherEntity.h"
#import "SecondTableViewCell.h"
#import "SavedDaysViewController.h"
#import "SelectedDayViewController.h"

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#endif

@interface SavedDaysViewController () <UITextFieldDelegate, DatePickerViewDelegate>

@property (strong, nonatomic) NSSet *searchSet;
@property (weak, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableArray *days;
@property (strong, nonatomic) NSMutableArray *resultsArray;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (strong, nonatomic) DatePickerView *datePickerView;
@property (weak, nonatomic) IBOutlet UIButton *setDatesButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *darkerLayerOfTableView;
@property (weak, nonatomic) IBOutlet UITableView *savedDaysTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *searchResultsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchResultsHeightConstraint;

@end

@implementation SavedDaysViewController
    CGRect searchResultsFrame1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    searchResultsFrame1 = _searchResultsTableView.frame;
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadDataFromCoreData];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SecondTableViewCell *cell = (SecondTableViewCell *)sender;
    SelectedDayViewController *nextController = [segue destinationViewController];
    nextController.entity = cell.entity;
    nextController.bgImage = _bgImage;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpView {
    self.navigationView.layer.shadowRadius = 0;
    self.navigationView.layer.masksToBounds = NO;
    self.navigationView.layer.shadowOpacity = 0.1;
    self.navigationView.layer.shadowOffset = CGSizeMake(0, 1);
   
    self.backgroundImageView.image = _bgImage;
    self.searchResultsTableView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    
    self.searchTextField.delegate = self;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.datePickerView = [DatePickerView datePickerView:self];
    [self.view addSubview:_datePickerView];
    self.datePickerView.center = CGPointMake(self.view.center.x, 50 + self.datePickerView.frame.size.height/2);
    
    UITapGestureRecognizer *closeDateGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(closeDateSearch)];
    
    closeDateGesture.cancelsTouchesInView = NO;
    [self.savedDaysTableView addGestureRecognizer:closeDateGesture];
}

#pragma mark Search Text Field methods
-(void)textFieldDidChange :(UITextField *) textField {
    if(![textField.text isEqualToString:@""]){
        NSMutableArray *searchArray = [NSMutableArray arrayWithArray:[_searchSet allObjects]];
        NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", textField.text];
        self.resultsArray = [NSMutableArray arrayWithArray:[searchArray filteredArrayUsingPredicate:predicate]];
 
        searchResultsFrame1.size.height = [_resultsArray count] * 44;
        [self reloadSearchTableView];
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.searchResultsTableView.frame = CGRectMake(searchResultsFrame1.origin.x, searchResultsFrame1.origin.y , searchResultsFrame1.size.width, searchResultsFrame1.size.height);
                         }];
        
        [self alphaChangeAnimation:0.3];
    }else {
        [self alphaChangeAnimation:1];
        [self.resultsArray removeAllObjects];
        [self reloadSearchTableView];
    }
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    [self.view endEditing:YES];
    [self.resultsArray removeAllObjects];
    self.location = nil;
    [self loadDataFromCoreData];
    [self reloadSearchTableView];
    [self alphaChangeAnimation:1];

    return YES;
}

#pragma mark Dates Select open/close
- (void)closeDateSearch {
    if(!_datePickerView.hidden){
        [_datePickerView hideWithCompletionBlock:^(BOOL finished){
            if(finished){
                [UIView animateWithDuration:0.4
                                 animations:^{
                                     self.savedDaysTableView.alpha = 1;
                                 }];
            }
        }];
    }
}

- (IBAction)openDatesChooseView:(id)sender {
    if(_datePickerView.hidden){
        self.savedDaysTableView.alpha = 0.5;
        [_datePickerView showInView:self.view];
    }else{
        [self closeDateSearch];
    }
}

- (void)alphaChangeAnimation:(double)x {
    [UIView animateWithDuration:0.5
                     animations:^{
                         _savedDaysTableView.alpha = x;
                     }];
}

#pragma CoreDate methods
-(void)reloadSearchTableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        _searchResultsHeightConstraint.constant = [_resultsArray count] * 44;
        [_searchResultsTableView reloadData];
        
    });
}

-(void)loadDataFromCoreData {
    NSString *dateAttributeName = @"time";
    NSString *cityAttributeName = @"city";
    NSPredicate *predicate;
    
    if(_location){
        predicate = [NSPredicate predicateWithFormat:@"%K == %@", cityAttributeName, _location];
    }
    if(_fromDate){
        predicate = [NSPredicate predicateWithFormat:@"(%K >= %@) AND (%K <= %@)", dateAttributeName, _fromDate, dateAttributeName, _toDate];
    }
    if(_location && _fromDate){
        predicate = [NSPredicate predicateWithFormat:@"(%K >= %@) AND (%K <= %@) AND (%K == %@)", dateAttributeName, _fromDate, dateAttributeName, _toDate, cityAttributeName, _location];
    }
    
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"CityWeather"];
    [fetchRequest setPredicate:predicate];
    self.days = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    self.searchSet = [NSSet setWithArray:[self getSavedCityNames]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_savedDaysTableView reloadData];
        [_searchResultsTableView reloadData];
    });
    
}

- (NSMutableArray *)getSavedCityNames {
    NSMutableArray *cityNames = [NSMutableArray new];
    for(CityWeatherEntity *entity in _days){
        [cityNames addObject:entity.city];
    }
    
    return cityNames;
}

#pragma mark TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([_savedDaysTableView isEqual:tableView]){
        return [_days count];
    }else {
        return [_resultsArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([_savedDaysTableView isEqual:tableView]){
        SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSecondTableViewCell];
        if(!cell){
            [tableView registerNib:[UINib nibWithNibName:kSecondTableViewCell bundle:nil] forCellReuseIdentifier:kSecondTableViewCell];
            cell = [tableView dequeueReusableCellWithIdentifier:kSecondTableViewCell];
        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell initWithData:_days[indexPath.row]];
        
        return cell;
    }else {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = _resultsArray[indexPath.row];
        
        return cell;

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.searchResultsTableView isEqual:tableView]){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self.view endEditing:YES];
        [self alphaChangeAnimation:1];
        [self.resultsArray removeAllObjects];
        self.searchTextField.text = cell.textLabel.text;

        searchResultsFrame1.size.height = 0;
        
        [self reloadSearchTableView];
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchResultsTableView.frame = CGRectMake(searchResultsFrame1.origin.x, searchResultsFrame1.origin.y , searchResultsFrame1.size.width, searchResultsFrame1.size.height);
                         }];

        self.location = cell.textLabel.text;
        [self loadDataFromCoreData];
    }else {
        if([@(_savedDaysTableView.alpha)  isEqual: @1]){
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [self performSegueWithIdentifier:@"moreDetails" sender:cell];
        }
    }
}

#pragma mark DatePickerViewDelegate
-(void)selectDates:(NSDate *)fromDate and:(NSDate *)toDate {
    self.fromDate = fromDate;
    self.toDate = toDate;
    [self loadDataFromCoreData];
}

-(void)changeAlpha {
    [UIView animateWithDuration:0.5 animations:^{
        self.savedDaysTableView.alpha = 1; 
    }];
}

-(void)clearDates {
    self.toDate = nil;
    self.fromDate = nil;
    [self changeAlpha];
    [self loadDataFromCoreData];
}

@end
