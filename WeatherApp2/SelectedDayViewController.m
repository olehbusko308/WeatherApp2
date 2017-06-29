//
//  SelectedDayViewController.m
//  WeatherApp2
//
//  Created by Oleh Busko on 26/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "DatePickerView.h"
#import "SelectedDayViewController.h"

@interface SelectedDayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunsetLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *moonPhaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *cloudCoverLabel;
@property (weak, nonatomic) IBOutlet UILabel *windBearingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation SelectedDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInformationToLabels];
    self.backgroundImageView.image = _bgImage;
    self.summaryLabel.layer.borderWidth = 0.5;
    self.summaryLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.iconImageView.image = [UIImage imageNamed:[_entity.icon stringByAppendingString:@"-large"]];
}
    
- (void)addInformationToLabels {
    self.cityLabel.text = _entity.city;
    self.summaryLabel.text = _entity.summary;
    self.dateLabel.text = [Utility formatDateToString:_entity.time];
    self.humidityLabel.text = [self.humidityLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.humidity stringValue]]];
    self.moonPhaseLabel.text = [self.moonPhaseLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.moonPhase stringValue]]];
    self.cloudCoverLabel.text = [self.cloudCoverLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.cloudCover stringValue]]];
    self.windBearingLabel.text = [self.windBearingLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.windBearing stringValue]]];
    self.sunsetLabel.text = [self.sunsetLabel.text stringByAppendingString:[@"  " stringByAppendingString:[Utility formatDateToString2:_entity.sunsetTime]]];
    self.sunriseLabel.text = [self.sunriseLabel.text stringByAppendingString:[@"  " stringByAppendingString:[Utility formatDateToString2:_entity.sunriseTime]]];
    self.minTemperatureLabel.text = [self.minTemperatureLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.lowTemp stringByAppendingString:@"°"]]];
    self.maxTemperatureLabel.text = [self.maxTemperatureLabel.text stringByAppendingString:[@"  " stringByAppendingString:[_entity.highTemp stringByAppendingString:@"°"]]];
    self.pressureLabel.text = [self.pressureLabel.text stringByAppendingString:[@"  " stringByAppendingString:[[_entity.pressure stringValue] stringByAppendingString:@" hPa"]]];
    self.windSpeedLabel.text = [self.windSpeedLabel.text stringByAppendingString:[@"  " stringByAppendingString:[[_entity.windSpeed stringValue] stringByAppendingString:@" mph"]]];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Navigation
- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
