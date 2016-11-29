//
//  NSArray+UITableViewController.h
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (UITableViewController)

- (NSMutableArray<NSMutableArray *> *)sectionIndexDataSourceWithNameBlock:(NSString *(^)(id))name;

+ (NSArray *)arrayWithDataSource:(NSArray<NSArray *> *)dataSource;

@end
