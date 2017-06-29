//
//  WeatherAPIRequest.m
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "WeatherAPIRequest.h"

@implementation WeatherAPIRequest


-(NSString *)getHTTPMethod {
    return @"GET";
}

-(NSString *)getContentType {
    return @"application/json";
}

-(BaseResponse *)bindData:(NSData *)data{
    
    
    WeatherAPIResponse *response = [WeatherAPIResponse new];
    NSDictionary *dataInDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];

    DayData *day = [[DayData alloc]initWithDictionary:dataInDic];
    HourData *hour = [[HourData alloc]initWithDictionary:dataInDic];
    
    response.dayData = day;
    response.hourData = hour;

    return response;
}

-(NSString *)objectSignature{
    return self.coordinates;
}


@end
