//
//  WakeUp2ViewController.m
//  SleepTracker
//
//  Created by 蘇健豪1 on 2014/12/26.
//  Copyright (c) 2014年 蘇健豪. All rights reserved.
//

#import "WakeUp2ViewController.h"

#import "WakeUpTableViewController.h"

#import "SleepDataModel.h"
#import "SleepData.h"

@interface WakeUp2ViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) NSString *DateType;
@property (strong, nonatomic) NSDate *goToBedTime;
@property (strong, nonatomic) NSDate *wakeUpTime;
@property (nonatomic, strong) WakeUpTableViewController *wakeUpViewController;

@property (strong, nonatomic) NSDateFormatter *formatter;

@property (strong, nonatomic) SleepDataModel *sleepDataModel;
@property (strong, nonatomic) SleepData *sleepData;
@property (strong, nonatomic) NSArray *fetchDataArray;

@end

@implementation WakeUp2ViewController

@synthesize formatter, fetchDataArray, DateType, goToBedTime, wakeUpTime;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"u/MM/dd EEE ahh:mm"];
    
    self.sleepDataModel = [[SleepDataModel alloc] init];
    fetchDataArray = [self.sleepDataModel fetchSleepDataSortWithAscending:NO];
    const NSInteger LATEST_DATA = 0;
    self.sleepData = fetchDataArray[LATEST_DATA];
    if ([DateType isEqualToString:@"goToBedTime"])
    {
        self.datePicker.date = goToBedTime;
        
        self.datePicker.maximumDate = wakeUpTime;  //上床時間可設定的最大值限制為起床時間
        if ([fetchDataArray count] >= 2)
        {
            self.sleepData = fetchDataArray[1];
            self.datePicker.minimumDate = self.sleepData.wakeUpTime;  //上床時間可設定的最小值限制為上一筆資料的起床時間
        }
        
        self.dateLabel.text = [formatter stringFromDate:goToBedTime];
    }
    else if ([DateType isEqualToString:@"wakeUpTime"])
    {
        self.datePicker.date = wakeUpTime;
        self.datePicker.minimumDate = goToBedTime;  //起床時間可設定的最小值限制為上床時間
        self.datePicker.maximumDate = [NSDate date];  //最大值為現在時間，起床時間不可以設為未來的時間，要不計算清醒時間會錯亂
        
        self.dateLabel.text = [formatter stringFromDate:wakeUpTime];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        // back button was pressed.  We know this is true because self is no longer in the navigation stack.
        
        if ([self.title isEqualToString:@"上床時間"]) {    //更新資料
            [self.wakeUpViewController setValue:self.datePicker.date forKey:@"goToBedTime"];
        }
        else if ([self.title isEqualToString:@"起床時間"]) {
            [self.wakeUpViewController setValue:self.datePicker.date forKey:@"wakeUpTime"];
        }
    }
    [super viewWillDisappear:animated];
}

- (IBAction)valueChanged:(id)sender {
    self.dateLabel.text = [formatter stringFromDate:self.datePicker.date];
}

@end
