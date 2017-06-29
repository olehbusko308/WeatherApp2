//
//  TableViewCell.h
//  WeatherApp2
//
//  Created by Oleh Busko on 31/05/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyEntity.h"
extern NSString *const kTableViewcell;

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) NSString *city;
@property (strong, nonatomic) DailyEntity *entity;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


-(void)initWithData:(DailyEntity *)entity andCity:(NSString *)city;

@end
