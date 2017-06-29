//
//  DailyEntity.h
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseData.h"

@interface DailyEntity : BaseData

@property (copy, nonatomic) NSString *icon;
@property (strong, nonatomic) NSDate *time;
@property (copy, nonatomic) NSString *ozone;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *dewPoint;
@property (copy, nonatomic) NSString *humidity;
@property (copy, nonatomic) NSString *pressure;
@property (copy, nonatomic) NSString *windSpeed;
@property (copy, nonatomic) NSString *moonPhase;
@property (copy, nonatomic) NSString *cloudCover;
@property (strong, nonatomic) NSDate *sunsetTime;
@property (copy, nonatomic) NSString *visibility;
@property (copy, nonatomic) NSString *windBearing;
@property (strong, nonatomic) NSDate *sunriseTime;
@property (copy, nonatomic) NSNumber *temperatureMax;
@property (copy, nonatomic) NSNumber *temperatureMin;
@property (copy, nonatomic) NSString *precipIntensity;
@property (copy, nonatomic) NSString *precipProbability;
@property (strong, nonatomic) NSDate *temperatureMaxTime;
@property (strong, nonatomic) NSDate *temperatureMinTime;
@property (copy, nonatomic) NSString *precipIntensityMax;

@property (copy, nonatomic) NSString *timeInString;
@end
