//
//  HourData.m
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "HourData.h"
#import "TypeCheck.h"

@implementation HourData

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        if(dic[@"hourly"] != NULL){
            if(dic[@"hourly"][@"data"] != NULL){
                if([dic[@"hourly"][@"data"] count] >= 24){
                    NSArray *array = [TypeCheck isArray:dic[@"hourly"][@"data"]];
                    NSMutableArray *mutableArray = [NSMutableArray new];
                    
                    for (NSDictionary*dic in array) {
                        HourlyEnitity *hourly = [[HourlyEnitity alloc]initWithDictionary:dic];
                        [mutableArray addObject:hourly];
                        
                    }
                    self.hourlyEntitiesArray = mutableArray;
                
                }
            }
        }
        
    }
    return self;
}
@end
