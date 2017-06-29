//
//  DayData.m
//  WeatherApp2
//
//  Created by Oleh Busko on 09/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "DayData.h"
#import "TypeCheck.h"

@implementation DayData

-(id)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        if(dic[@"daily"] != NULL){
            if(dic[@"daily"][@"data"] != NULL){
                if([dic[@"daily"][@"data"] count] >= 8){
                    
                    NSArray *array = [TypeCheck isArray:dic[@"daily"][@"data"]];
                    NSMutableArray *mutableArray = [NSMutableArray new];
                    
                    for (NSDictionary *dic in array) {
                        DailyEntity *daily = [[DailyEntity alloc]initWithDictionary:dic];
                        [mutableArray addObject:daily];
                        
                    }
                    self.dailyEntitiesArray = mutableArray;
                
                }
            }
        }
        
    }
    return self;
}

@end
