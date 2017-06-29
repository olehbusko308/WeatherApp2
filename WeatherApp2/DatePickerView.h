//
//  DatePickerView.h
//  WeatherApp2
//
//  Created by Oleh Busko on 22/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickerView;

@protocol DatePickerViewDelegate <NSObject>
-(void)clearDates;
-(void)changeAlpha;
-(void)selectDates:(NSDate *)fromDate and:(NSDate *)toDate;

@end

@interface DatePickerView : UIView

@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

- (void)showInView:(UIView *)parentView;
- (void)hideWithCompletionBlock:(void (^)(BOOL finished))completion;
+ (DatePickerView *)datePickerView:(id<DatePickerViewDelegate>)delegate;

@end
