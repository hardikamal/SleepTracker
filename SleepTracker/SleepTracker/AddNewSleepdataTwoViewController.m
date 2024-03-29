//
//  AddNewSleepdataTwoViewController.m
//  SleepTracker
//
//  Created by 蘇健豪1 on 2015/1/30.
//  Copyright (c) 2015年 蘇健豪. All rights reserved.
//

#import "AddNewSleepdataTwoViewController.h"

#import "AddNewSleepdataTwoViewController.h"

#import "SleepDataModel.h"
#import "SleepData.h"

@interface AddNewSleepdataTwoViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) NSString *DateType;
@property (strong, nonatomic) NSDate *goToBedTime;
@property (strong, nonatomic) NSDate *wakeUpTime;
@property (strong, nonatomic) AddNewSleepdataTwoViewController *addNewSleepdataTwoViewController;

@property (strong, nonatomic) SleepDataModel *sleepDataModel;
@property (strong, nonatomic) SleepData *sleepData;
@property (strong, nonatomic) NSArray *fetchDataArray;

@end

@implementation AddNewSleepdataTwoViewController

@synthesize dateFormatter, DateType, goToBedTime, wakeUpTime, fetchDataArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"u/MM/dd EEE ahh:mm"];
    
    self.sleepDataModel = [[SleepDataModel alloc] init];
    fetchDataArray = [self.sleepDataModel fetchSleepDataSortWithAscending:NO];
    if ([DateType isEqualToString:@"goToBedTime"])
    {
        self.datePicker.date = goToBedTime;
        self.dateLabel.text = [dateFormatter stringFromDate:goToBedTime];
    }
    else if ([DateType isEqualToString:@"wakeUpTime"])
    {
        self.datePicker.date = wakeUpTime;
        self.dateLabel.text = [dateFormatter stringFromDate:wakeUpTime];
    }
}

- (IBAction)valueChanged:(id)sender {
    self.dateLabel.text = [dateFormatter stringFromDate:self.datePicker.date];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    if (!parent) {
        if ([DateType isEqualToString:@"goToBedTime"]) {
            [self.addNewSleepdataTwoViewController setValue:self.datePicker.date forKey:@"goToBedTime"];
        }
        else if ([DateType isEqualToString:@"wakeUpTime"]) {
            [self.addNewSleepdataTwoViewController setValue:self.datePicker.date forKey:@"wakeUpTime"];
        }
    }
}

@end
