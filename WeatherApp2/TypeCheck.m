//
//  TypeCheck.m
//  WeatherApp2
//
//  Created by Oleh Busko on 06/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "TypeCheck.h"

@implementation TypeCheck

+(NSNumber*)isBool:(NSNumber*)numberToCheck {
    if([numberToCheck isKindOfClass:[NSNull class]]){
        return @NO;
    }
    
    return numberToCheck == nil ? @NO : numberToCheck;
}

+(NSNumber *)isNumber:(NSNumber *)numberToCheck; {
    if([numberToCheck isKindOfClass:[NSNull class]]){
        return @0;
    }
    
    return numberToCheck == nil ? @0 : numberToCheck;
}

+(NSDate *)isDate:(NSDate *)dateToCheck {
    if([dateToCheck isKindOfClass:[NSNull class]]){
        return [NSDate date];
    }
    
    return dateToCheck == nil ? [NSDate date] : dateToCheck;
}

+(NSArray *)isArray:(NSArray *)arrayToCheck {
    if([arrayToCheck isKindOfClass:[NSNull class]]){
        return @[];
    }
    
    return arrayToCheck == nil ? @[] : arrayToCheck;
}


+(NSString *)isString:(NSString *)stringToCheck {
    if ([stringToCheck isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    return stringToCheck == nil ? @"": stringToCheck;
}

@end

