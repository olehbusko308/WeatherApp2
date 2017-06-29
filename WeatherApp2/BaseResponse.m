//
//  BaseResponse.m
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

-(void)checkForErrors: (NSError *)error{
    if(error.code != 200 && error.code != 201){
        NSLog(@"Error:%ld \n Domain:%@ \n User Info:%@", (long)error.code, error.domain, error.userInfo);
    }
}

@end
