//
//  SecondTableViewCell.h
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeatherEntity.h"

extern NSString *const kSecondTableViewCell;

@interface SecondTableViewCell : UITableViewCell

@property (strong, nonatomic) CityWeatherEntity *entity;

-(void)initWithData:(CityWeatherEntity *)entity;

@end
