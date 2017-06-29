//
//  Utility.m
//  WeatherApp2
//
//  Created by Oleh Busko on 06/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "TypeCheck.h"

@implementation Utility

+(NSString *)getHour:(NSDate *)date withTimeZone:(NSTimeZone *)timezone{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH"];
    [dateFormatter setTimeZone:timezone];
    
    return [dateFormatter stringFromDate:date];
}

+(NSString *)getDay:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    return [dateFormatter stringFromDate:date];
}

+(NSString *)convertFahrenheitToCelsius:(NSNumber *)temp {
    NSNumber *numberTemp = [NSNumber numberWithDouble:([temp intValue] - 32) / 1.8];
    return [NSString stringWithFormat:@"%.0f", [numberTemp doubleValue]];
}

+(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+(NSString *)formatDateToString:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM/yyyy"];

    return [format stringFromDate:date];
}

+(NSString *)formatDateToString2:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"HH:mm"];
    
    return [format stringFromDate:date];
}

@end
