//
//  StatisticViewController.m
//  SleepTracker
//
//  Created by 蘇健豪1 on 2014/12/26.
//  Copyright (c) 2014年 蘇健豪. All rights reserved.
//

#import "StatisticViewController.h"

#import "Statistic.h"

@interface StatisticViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (weak, nonatomic) IBOutlet UILabel *goToBedTimeMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *goToBedTimeAvgLabel;
@property (weak, nonatomic) IBOutlet UILabel *goToBedTimeMaxLabel;

@property (weak, nonatomic) IBOutlet UILabel *wakeUpTimeMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeUpTimeAvgLabel;
@property (weak, nonatomic) IBOutlet UILabel *wakeUpTimeMaxLabel;

@property (weak, nonatomic) IBOutlet UILabel *sleepTimeMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeAvgLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepTimeMaxLabel;

@property (strong, nonatomic) Statistic *statistic;
@property (strong, nonatomic) NSArray *goToBedTimeData;
@property (strong, nonatomic) NSArray *wakeUpTimeData;
@property (strong, nonatomic) NSArray *sleepTimeData;


@end

@implementation StatisticViewController

@synthesize goToBedTimeData, wakeUpTimeData, sleepTimeData;

- (Statistic *)statistic
{
    if (!_statistic) {
        _statistic = [[Statistic alloc]init];
    }
    return _statistic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self judgeWhichSegmentSelected];
}

- (IBAction)segmentChange:(id)sender
{
    [self judgeWhichSegmentSelected];
}

- (void)judgeWhichSegmentSelected
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            sleepTimeData = [self.statistic showSleepTimeDataInTheRecent:7];
            goToBedTimeData = [self.statistic showGoToBedTimeDataInTheRecent:7];
            wakeUpTimeData = [self.statistic showWakeUpTimeDataInTheRecent:7];
            break;
        case 1:
            sleepTimeData = [self.statistic showSleepTimeDataInTheRecent:30];
            goToBedTimeData = [self.statistic showGoToBedTimeDataInTheRecent:30];
            wakeUpTimeData = [self.statistic showWakeUpTimeDataInTheRecent:30];
            break;
        case 2:
            sleepTimeData = [self.statistic showSleepTimeDataInTheRecent:183];
            goToBedTimeData = [self.statistic showGoToBedTimeDataInTheRecent:183];
            wakeUpTimeData = [self.statistic showWakeUpTimeDataInTheRecent:183];
            break;
    }
    
    [self showStatistic];
}

- (void)showStatistic
{
    self.sleepTimeMinLabel.text = [self.statistic stringFromTimeInterval:[sleepTimeData[0] floatValue]];
    self.sleepTimeMaxLabel.text = [self.statistic stringFromTimeInterval:[sleepTimeData[1] floatValue]];
    self.sleepTimeAvgLabel.text = [self.statistic stringFromTimeInterval:[sleepTimeData[2] floatValue]];
    self.goToBedTimeMinLabel.text = [self.statistic stringFromTimeInterval:[goToBedTimeData[0] floatValue]];
    self.goToBedTimeMaxLabel.text = [self.statistic stringFromTimeInterval:[goToBedTimeData[1] floatValue]];
    self.goToBedTimeAvgLabel.text = [self.statistic stringFromTimeInterval:[goToBedTimeData[2] floatValue]];
    self.wakeUpTimeMinLabel.text = [self.statistic stringFromTimeInterval:[wakeUpTimeData[0] floatValue]];
    self.wakeUpTimeMaxLabel.text = [self.statistic stringFromTimeInterval:[wakeUpTimeData[1] floatValue]];
    self.wakeUpTimeAvgLabel.text = [self.statistic stringFromTimeInterval:[wakeUpTimeData[2] floatValue]];
}

@end
