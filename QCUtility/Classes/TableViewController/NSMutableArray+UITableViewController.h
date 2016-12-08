//
//  NSMutableArray+UITableViewController.h
//  TableViewDemo
//
//  Created by Qi Chen on 11/19/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray<ObjectType> (UITableViewController)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
- (void)insertObject:(ObjectType)object atIndexPath:(NSIndexPath *)indexPath;
- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;
- (bool)removeSectionIfEmpty:(NSInteger)section;
- (BOOL)removeObjectAtIndexPath:(NSIndexPath *)indexPath removeSectionIfEmpty:(BOOL)removeSectionIfEmpty;
- (void)removeObjectsAtIndexPathes:(NSSet *)indexPathes removeSectionIfEmpty:(BOOL)removeSectionIfEmpty;
- (void)removeRowObject:(id)object removeEmptySection:(BOOL)removeEmptySection;
- (void)removeRowObjectsInArray:(NSArray *)array removeEmptySection:(BOOL)removeEmptySection;

@end
