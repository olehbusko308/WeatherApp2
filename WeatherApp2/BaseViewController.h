//
//  BaseViewController.h
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BaseViewController : UIViewController

- (void)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message onController:(UIViewController *)controller;
- (NSManagedObjectContext *)managedObjectContext;
- (BOOL)isNight:(NSDate *)sunset and:(NSDate *)sunrise timezone:(NSTimeZone *)timezone;

@end
