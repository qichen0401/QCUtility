//
//  NSMutableArray+UITableViewController.m
//  TableViewDemo
//
//  Created by Qi Chen on 11/19/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "NSMutableArray+UITableViewController.h"
#import <UIKit/UIKit.h>

@implementation NSMutableArray (UITableViewController)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath {
    return self[indexPath.section][indexPath.row];
}

- (void)insertObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    [self[indexPath.section] insertObject:object atIndex:indexPath.row];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    [self[indexPath.section] removeObjectAtIndex:indexPath.row];
}

- (bool)removeSectionIfEmpty:(NSInteger)section {
    if ([self[section] count] == 0) {
        [self removeObjectAtIndex:section];
        return true;
    } else {
        return false;
    }
}

@end
