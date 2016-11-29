//
//  BaseTableViewController.h
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

@property (strong, nonatomic, nonnull) NSMutableArray<NSMutableArray *> *dataSource;
@property (strong, nonatomic, nonnull) NSArray *rawData;  //used for section index tableview
@property (strong, nonatomic, nonnull) NSString * _Nonnull (^name)(_Nonnull id);
@property (nonatomic) bool supportDelete;
@property (nonatomic) bool supportRearranging;
@property (nonatomic) bool showSectionIndex;

//override
- (void)registerForCellReuseIdentifier;
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
