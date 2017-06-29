//
//  TableViewCell.m
//  WeatherApp2
//
//  Created by Oleh Busko on 31/05/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "AppDelegate.h"
#import "DailyEntity.h"
#import "TableViewCell.h"

NSString *const kTableViewcell = @"TableViewCell";

@interface TableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;

@end

@implementation TableViewCell

-(void)initWithData:(DailyEntity *)entity andCity:(NSString *)city {
    _weatherImage.image = [UIImage imageNamed:entity.icon];
    _titleLabel.text = [[Utility getDay:entity.time] substringToIndex:3];
    _lowTempLabel.text = [Utility convertFahrenheitToCelsius:entity.temperatureMin];
    _highTempLabel.text  = [Utility convertFahrenheitToCelsius:entity.temperatureMax];
    _city   = city;
    _entity = entity;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.alpha = 0.2;
    selectedBackgroundView.backgroundColor = [UIColor clearColor];
    [selectedBackgroundView setBackgroundColor:[UIColor blackColor]];
    [self setSelectedBackgroundView:selectedBackgroundView];
}

@end
