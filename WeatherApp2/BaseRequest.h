//
//  BaseRequest.h
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseResponse.h"
#import "WeatherAPIResponse.h"
#import <Foundation/Foundation.h>


@interface BaseRequest : NSObject 
    
-(void)sendRequest:(NSString *)url completionHandler:(void (^) (BaseResponse *response, NSError *error))callback;

-(NSString *)getHTTPMethod;
-(NSString *)getContentType;
-(NSString *)objectSignature;
-(BaseResponse *)bindData:(NSData *)data;

@end
