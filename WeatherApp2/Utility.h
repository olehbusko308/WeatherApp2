//
//  Utility.h
//  WeatherApp2
//
//  Created by Oleh Busko on 06/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Utility : NSObject

+(NSString *)getDay:(NSDate *)date;
+(NSString *)formatDateToString:(NSDate *)date;
+(NSString *)formatDateToString2:(NSDate *)date;
+(UIColor *)colorFromHexString:(NSString *)hexString;
+(NSString *)convertFahrenheitToCelsius:(NSNumber *)temp;
+(NSString *)getHour:(NSDate *)date withTimeZone:(NSTimeZone *)timezone;

@end
