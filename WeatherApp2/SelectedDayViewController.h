//
//  SelectedDayViewController.h
//  WeatherApp2
//
//  Created by Oleh Busko on 26/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityWeatherEntity.h"
#import "BaseViewController.h"

@interface SelectedDayViewController : BaseViewController

@property (strong, nonatomic) CityWeatherEntity *entity;
@property (strong, nonatomic) UIImage *bgImage;

@end
