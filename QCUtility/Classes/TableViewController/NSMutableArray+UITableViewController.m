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

- (BOOL)removeObjectAtIndexPath:(NSIndexPath *)indexPath removeSectionIfEmpty:(BOOL)removeSectionIfEmpty {
    NSMutableArray *section = self[indexPath.section];
    [section removeObjectAtIndex:indexPath.row];
    if (removeSectionIfEmpty && section.count == 0) {
        [self removeObjectAtIndex:indexPath.section];
        return true;
    } else {
        return false;
    }
}

- (void)removeObjectsAtIndexPathes:(NSSet *)indexPathes removeSectionIfEmpty:(BOOL)removeSectionIfEmpty {
    NSArray *indexPathArray = [indexPathes sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"section" ascending:false], [NSSortDescriptor sortDescriptorWithKey:@"row" ascending:false]]];
    for (NSIndexPath *indexPath in indexPathArray) {
        [self removeObjectAtIndexPath:indexPath removeSectionIfEmpty:removeSectionIfEmpty];
    }
}

- (void)removeRowObject:(id)object removeEmptySection:(BOOL)removeEmptySection {
    for (int i = 0; i < self.count; i++) {
        NSMutableArray *array = self[i];
        [array removeObject:object];
        if (removeEmptySection && [self removeSectionIfEmpty:i]) {
            i--;
        }
    }
}

- (void)removeRowObjectsInArray:(NSArray *)array removeEmptySection:(BOOL)removeEmptySection {
    for (id object in array) {
        [self removeRowObject:object removeEmptySection:removeEmptySection];
    }
}

@end
