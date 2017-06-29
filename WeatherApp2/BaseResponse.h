//
//  BaseResponse.h
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResponse : NSObject

@property (strong, nonatomic) NSData *responseData;
@property (strong, nonatomic) NSError *error;

-(void)checkForErrors: (NSError *)error;

@end

