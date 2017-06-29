//
//  ViewController.h
//  WeatherApp2
//
//  Created by Oleh Busko on 31/05/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate>

- (IBAction)openSavedList:(id)sender;

@end
