//
//  HourlyEnitity.h
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseData.h"

@interface HourlyEnitity : BaseData

@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSDate   *time;
@property (strong, nonatomic) NSString *ozone;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *dewPoint;
@property (strong, nonatomic) NSString *humidity;
@property (strong, nonatomic) NSString *pressure;
@property (strong, nonatomic) NSString *windSpeed;
@property (strong, nonatomic) NSString *cloudCover;
@property (strong, nonatomic) NSString *visibility;
@property (strong, nonatomic) NSString *windBearing;
@property (strong, nonatomic) NSNumber *temperature;
@property (strong, nonatomic) NSString *precipIntensity;
@property (strong, nonatomic) NSString *precipProbability;

@end
