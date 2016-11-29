//
//  NSArray+UITableViewController.m
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "NSArray+UITableViewController.h"
#import "NSString+UITableViewController.h"
#import <UIKit/UIKit.h>

@implementation NSArray (UITableViewController)

- (NSMutableArray<NSMutableArray *> *)sectionIndexDataSourceWithNameBlock:(NSString *(^)(id))name {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    for (id object in self) {
        NSString *key = [name(object) sectionTitle];
        if ([dictionary objectForKey:key]) {
            [[dictionary objectForKey:key] addObject:object];
        } else {
            [dictionary setObject:[NSMutableArray arrayWithObject:object] forKey:key];
        }
    }
    NSMutableArray *dataSource = [NSMutableArray new];
    NSArray *sectionTitles = [[UILocalizedIndexedCollation currentCollation] sectionTitles];
    for (NSString *key in sectionTitles) {
        NSMutableArray *section = [dictionary objectForKey:key];
        if (section) {
            [section sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                return [name(obj1) localizedStandardCompare:name(obj2)];
            }];
            [dataSource addObject:section];
        }
    }
    return dataSource;
}

+ (NSArray *)arrayWithDataSource:(NSArray<NSArray *> *)dataSource {
    NSMutableArray *array = [NSMutableArray new];
    for (NSArray *section in dataSource) {
        [array addObjectsFromArray:section];
    }
    return array;
}

@end
