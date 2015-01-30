//
//  AlarmTableViewController.m
//  SleepTracker
//
//  Created by 蘇健豪1 on 2015/1/30.
//  Copyright (c) 2015年 蘇健豪. All rights reserved.
//

#import "AlarmTableViewController.h"

@interface AlarmTableViewController ()

@property (strong, nonatomic) NSArray *array;

@end

@implementation AlarmTableViewController

@synthesize array;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    array = @[@"設定時間", @"鈴聲"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = array[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *page2;
    
    if (indexPath.row == 0) {
        page2 = [self.storyboard instantiateViewControllerWithIdentifier:@"setAlarm"];
    } else if (indexPath.row == 1) {
        page2 = [self.storyboard instantiateViewControllerWithIdentifier:@"Ringtones"];
    }
    
    [self.navigationController pushViewController:page2 animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
