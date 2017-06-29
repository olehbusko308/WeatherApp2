//
//  WeatherAPIRequest.h
//  WeatherApp2
//
//  Created by Oleh Busko on 08/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "BaseRequest.h"
#import "BaseResponse.h"
#import "WeatherAPIResponse.h"

@interface WeatherAPIRequest : BaseRequest
@property (copy, nonatomic) NSString *coordinates;

@end

