//
//  SecondTableViewCell.m
//  WeatherApp2
//
//  Created by Oleh Busko on 13/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "SecondTableViewCell.h"

NSString *const kSecondTableViewCell = @"SecondTableViewCell";

@interface SecondTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;

@end

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)initWithData:(CityWeatherEntity *)entity{
    self.entity = entity;
    self.cityLabel.text = entity.city;
    self.lowTempLabel.text = entity.lowTemp;
    self.highTempLabel.text = entity.highTemp;
    self.dateLabel.text = [Utility formatDateToString:entity.time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    selectedBackgroundView.backgroundColor = [UIColor clearColor];
    selectedBackgroundView.alpha = 0.2;
    [self setSelectedBackgroundView:selectedBackgroundView];
}



@end
