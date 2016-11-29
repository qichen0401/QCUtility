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

@end
