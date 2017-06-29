//
//  HourlyDataView.m
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "HourlyDataView.h"

@interface HourlyDataView()
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation HourlyDataView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        [[NSBundle mainBundle] loadNibNamed:@"HourlyDataView" owner:self options:nil];
        [self addSubview:self.view];
        self.view.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)addData:(HourlyEnitity *) entity withTimeZone:(NSTimeZone *)timezone {
    _iconImageView.image = [UIImage imageNamed:entity.icon];
    _hourLabel.text = [Utility getHour:entity.time withTimeZone:timezone];
    _tempLabel.text = [[Utility convertFahrenheitToCelsius:entity.temperature] stringByAppendingString:@"°"];
}

@end
