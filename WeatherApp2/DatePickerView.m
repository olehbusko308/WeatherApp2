//
//  DatePickerView.m
//  WeatherApp2
//
//  Created by Oleh Busko on 22/06/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import "Utility.h"
#import "DatePickerView.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface DatePickerView ()

@property (strong, nonatomic) NSDate *toDate;
@property (strong, nonatomic) NSDate *fromDate;
@property (weak, nonatomic) IBOutlet UIView *toDateView;
@property (weak, nonatomic) IBOutlet UILabel *toDateLabel;
@property (weak, nonatomic) IBOutlet UIView *fromDateView;
@property (weak, nonatomic) IBOutlet UILabel *fromDateLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerView

+(DatePickerView *)datePickerView:(id<DatePickerViewDelegate>)delegate {
    DatePickerView *datePickerView = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:nil options:nil] firstObject];
    datePickerView.hidden = YES;
    datePickerView.delegate = delegate;
    datePickerView.layer.cornerRadius = 5;
    datePickerView.layer.masksToBounds = true;
    datePickerView.toDateView.backgroundColor = UIColorFromRGB(0x919292);
    [datePickerView.datePicker setValue:[UIColor whiteColor] forKey:@"textColor"];

    return datePickerView;
}

- (void)selectFromDate {
    self.toDate = self.datePicker.date;
    self.fromDateView.backgroundColor = [UIColor clearColor];
    self.toDateView.backgroundColor = UIColorFromRGB(0x919292);
}

- (void)selectToDate {
    self.fromDate = self.datePicker.date;
    self.toDateView.backgroundColor = [UIColor clearColor];
    self.fromDateView.backgroundColor = UIColorFromRGB(0x919292);
}

- (void)showInView:(UIView *)parentView {
    self.hidden = NO;
    self.layer.opacity = 0.5;
    self.layer.transform = CATransform3DMakeScale(.1f, .1f, 1.0);
    
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.layer.opacity = 1.0f;
                         self.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }];

}

- (void)hideWithCompletionBlock:(void (^)(BOOL finished))completion {
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.layer.opacity = 0.5;
                         self.layer.transform = CATransform3DMakeScale(.1f, .1f, 1.0);
                     } completion:^(BOOL finished){
                         self.hidden = YES;
                         if(completion != NULL){
                             completion(finished);
                         }
                     }];
}

- (IBAction)selectDates:(id)sender {
    if(_fromDate){
        if([_toDateView.backgroundColor isEqual:[UIColor clearColor]]){
            self.toDate = self.datePicker.date;
        }else{
            self.fromDate = self.datePicker.date;
        }

        [_delegate selectDates:self.fromDate and:self.toDate];
        [self hideWithCompletionBlock:^(BOOL finished){
            [_delegate changeAlpha];
        }];
    }
}

- (IBAction)clearDates:(id)sender {
    [_delegate clearDates];
    [self hideWithCompletionBlock:^(BOOL finished){
        [_delegate changeAlpha];
    }];
}


- (IBAction)fromDateGesture:(UITapGestureRecognizer *)sender {
    self.toDate = self.datePicker.date;
    self.fromDateView.backgroundColor = [UIColor clearColor];
    self.toDateView.backgroundColor = UIColorFromRGB(0x919292);
    self.toDateLabel.text = [Utility formatDateToString:self.toDate];
}

- (IBAction)toDateGesture:(UITapGestureRecognizer *)sender {
    self.fromDate = self.datePicker.date;
    self.toDateView.backgroundColor = [UIColor clearColor];
    self.fromDateView.backgroundColor = UIColorFromRGB(0x919292);
    self.fromDateLabel.text = [Utility formatDateToString:self.fromDate];
}

@end
