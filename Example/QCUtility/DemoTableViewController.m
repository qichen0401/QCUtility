//
//  DemoTableViewController.m
//  QCUtility
//
//  Created by Qi Chen on 3/21/17.
//  Copyright © 2017 Qi Chen. All rights reserved.
//

#import "DemoTableViewController.h"

@interface DemoTableViewController ()

@end

@implementation DemoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.rawData = @[@"aaaa", @"bbbb"];
    
    
    NSLog(@"%@", [NSString stringWithJSONObject:@[@"aaa", @"bbbb"]]);
    
    
    NSLog(@"%@", [NSString stringWithJSONObject:@{@"key1" : @"content1", @"key2" : @[@"aa", @"bb"]}]);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
