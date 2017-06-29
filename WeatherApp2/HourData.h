//
//  HourData.h
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//


#import "BaseData.h"
#import "HourlyEnitity.h"

@interface HourData : BaseData

@property (strong, nonatomic) NSArray <HourlyEnitity *> *hourlyEntitiesArray;

@end
