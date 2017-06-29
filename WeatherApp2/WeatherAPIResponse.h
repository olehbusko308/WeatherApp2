//
//  WeatherAPIResponse.h
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "DayData.h"
#import "HourData.h"
#import "BaseResponse.h"

@interface WeatherAPIResponse : BaseResponse

@property (nonatomic, strong) DayData *dayData;
@property (nonatomic, strong) HourData *hourData;
@end
