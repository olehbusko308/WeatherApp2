//
//  BaseRequest.m
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseRequest.h"

NSString *const kServerUrl = @"";
@implementation BaseRequest


-(void)sendRequest:(NSString *)urlString completionHandler:(void (^) (BaseResponse *response, NSError *error))callback{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, [self objectSignature]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:[self getHTTPMethod]];
    [request setValue:[self getContentType] forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sendRequest = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        if(data){
            callback([self bindData:data], error);
        }
    }];
    [sendRequest resume];
}


-(NSString *)getHTTPMethod {
    return @"POST";
}

-(NSString *)getContentType {
    return @"application/xml";
}

-(NSString *)objectSignature {
    NSAssert(NO, @"override");
    return @"";
}

-(BaseResponse *)bindData:(NSData *)data{
    NSAssert(NO, @"override");
    return nil;
}
@end
