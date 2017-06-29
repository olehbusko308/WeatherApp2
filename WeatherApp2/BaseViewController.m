//
//  BaseViewController.m
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message onController:(UIViewController *)controller {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:okAction];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = ((AppDelegate *)[[UIApplication sharedApplication]delegate]).persistentContainer.viewContext;
    return context;
}

- (BOOL)isNight:(NSDate *)sunset and:(NSDate *)sunrise timezone:(NSTimeZone *)timezone {
    NSDate *date = [NSDate new];
    NSTimeZone *currentTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone *nowTimeZone = timezone;

    NSTimeInterval interval = [nowTimeZone secondsFromGMTForDate:date] - [currentTimeZone secondsFromGMTForDate:date];
    NSDate *nowDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    NSDate *sunriseTime = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sunrise];
    NSDate *sunsetTime  = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sunset];
    
    if([nowDate compare:sunsetTime] == NSOrderedDescending ){
        return YES;
    }
    
    if([nowDate compare:sunriseTime] == NSOrderedAscending ){
        return YES;
    }
    
    return NO;
}

@end
