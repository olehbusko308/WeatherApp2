//
//  DayData.h
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseData.h"
#import "DailyEntity.h"
#import <Foundation/Foundation.h>

@interface DayData : BaseData

@property (strong, nonatomic) NSArray <DailyEntity *> *dailyEntitiesArray;
@end
