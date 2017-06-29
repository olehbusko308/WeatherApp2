//
//  HourlyDataView.h
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HourlyEnitity.h"

@interface HourlyDataView : UIView

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;

-(void)addData:(HourlyEnitity *) entity withTimeZone:(NSTimeZone *)timezone;

@end
