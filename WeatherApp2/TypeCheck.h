//
//  TypeCheck.h
//  WeatherApp2
//
//  Created by Oleh Busko on 06/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeCheck : NSObject

+(NSDate *)isDate:(NSDate *)dateToCheck;
+(NSArray *)isArray:(NSArray *)arrayToCheck;
+(NSNumber*)isBool:(NSNumber *)numberToCheck;
+(NSNumber *)isNumber:(NSNumber *)numberToCheck;
+(NSString *)isString:(NSString *)stringToCheck;

@end
