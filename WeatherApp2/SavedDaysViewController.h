//
//  SavedDaysViewController.h
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickerView.h"
#import "BaseViewController.h"

@interface SavedDaysViewController : BaseViewController

@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) NSDate *fromDate;
@property (strong, nonatomic) UIImage *bgImage;

- (IBAction)backAction:(id)sender;
- (IBAction)openDatesChooseView:(id)sender;

@end
