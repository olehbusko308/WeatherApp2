//
//  HourlyEnitity.m
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "TypeCheck.h"
#import "HourlyEnitity.h"

@implementation HourlyEnitity

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    
    if(self){
        self.icon              = [TypeCheck isString:dic[@"icon"]];
        self.ozone             = [TypeCheck isString:dic[@"ozone"]];
        self.summary           = [TypeCheck isString:dic[@"summary"]];
        self.pressure          = [TypeCheck isString:dic[@"pressure"]];
        self.dewPoint          = [TypeCheck isString:dic[@"dewPoint"]];
        self.humidity          = [TypeCheck isString:dic[@"humidity"]];
        self.windSpeed         = [TypeCheck isString:dic[@"windSpeed"]];
        self.visibility        = [TypeCheck isString:dic[@"visibility"]];
        self.cloudCover        = [TypeCheck isString:dic[@"cloudCover"]];
        self.windBearing       = [TypeCheck isString:dic[@"windBearing"]];
        self.precipIntensity   = [TypeCheck isString:dic[@"precipIntensity"]];
        self.precipProbability = [TypeCheck isString:dic[@"precipProbability"]];
        self.temperature       = [TypeCheck isNumber:[NSNumber numberWithDouble: [dic[@"temperature"] doubleValue]]];
        self.time              = [TypeCheck isDate: [NSDate dateWithTimeIntervalSince1970:[dic[@"time"] doubleValue]]];
    }
    
    return self;
}


@end
