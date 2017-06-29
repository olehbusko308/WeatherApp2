//
//  CityWeatherEntity.h
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface CityWeatherEntity : NSManagedObject

@property (copy, nonatomic) NSString *icon;
@property (strong, nonatomic) NSDate *time;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *summary;
@property (copy, nonatomic) NSString *lowTemp;
@property (copy, nonatomic) NSString *highTemp;
@property (copy, nonatomic) NSNumber *humidity;
@property (copy, nonatomic) NSNumber *pressure;
@property (copy, nonatomic) NSNumber *windSpeed;
@property (copy, nonatomic) NSNumber *moonPhase;
@property (copy, nonatomic) NSString *visibility;
@property (copy, nonatomic) NSNumber *cloudCover;
@property (strong, nonatomic) NSDate *sunsetTime;
@property (strong, nonatomic) NSDate *sunriseTime;
@property (copy, nonatomic) NSNumber *windBearing;

@end
