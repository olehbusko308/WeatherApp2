//
//  DailyEntity.m
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "TypeCheck.h"
#import "DailyEntity.h"

@implementation DailyEntity

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.timeInString       = [TypeCheck isString:dic[@"time"]];
        self.icon               = [TypeCheck isString:dic[@"icon"]];
        self.ozone              = [TypeCheck isString:dic[@"ozone"]];
        self.summary            = [TypeCheck isString:dic[@"summary"]];
        self.dewPoint           = [TypeCheck isString:dic[@"dewPoint"]];
        self.humidity           = [TypeCheck isString:dic[@"humidity"]];
        self.pressure           = [TypeCheck isString:dic[@"pressure"]];
        self.moonPhase          = [TypeCheck isString:dic[@"moonPhase"]];
        self.windSpeed          = [TypeCheck isString:dic[@"windSpeed"]];
        self.cloudCover         = [TypeCheck isString:dic[@"cloudCover"]];
        self.visibility         = [TypeCheck isString:dic[@"visibility"]];
        self.windBearing        = [TypeCheck isString:dic[@"windBearing"]];
        self.precipIntensity    = [TypeCheck isString:dic[@"precipIntensity"]];
        self.precipProbability  = [TypeCheck isString:dic[@"precipProbability"]];
        self.precipIntensityMax = [TypeCheck isString:dic[@"precipIntensityMax"]];
        self.time               = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"time"] doubleValue]]];
        self.temperatureMax     = [TypeCheck isNumber:[NSNumber numberWithDouble: [dic[@"temperatureMax"] doubleValue]]];
        self.temperatureMin     = [TypeCheck isNumber:[NSNumber numberWithDouble: [dic[@"temperatureMin"] doubleValue]]];
        self.sunsetTime         = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"sunsetTime"] doubleValue]]];
        self.sunriseTime        = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"sunriseTime"] doubleValue]]];
        self.temperatureMaxTime = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"temperatureMaxTime"] doubleValue]]];
        self.temperatureMinTime = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"temperatureMinTime"] doubleValue]]];
            
    }
    return self;
}

@end
