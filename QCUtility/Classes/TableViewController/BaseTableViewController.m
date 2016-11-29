//
//  BaseTableViewController.m
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "BaseTableViewController.h"
#import "NSString+UITableViewController.h"
#import "NSArray+UITableViewController.h"
#import "NSMutableArray+UITableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)setDataSource:(NSMutableArray<NSMutableArray *> *)dataSource {
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (void)setRawData:(NSArray *)rawData {
    self.dataSource = [rawData sectionIndexDataSourceWithNameBlock:self.name];
    self.showSectionIndex = true;
}

- (NSArray *)rawData {
    return [NSArray arrayWithDataSource:self.dataSource];
}

- (NSString *(^)(id))name {
    if (_name) {
        return _name;
    } else {
        return ^(id object) {
            if ([object isKindOfClass:[NSString class]]) {
                return (NSString *)object;
            } else {
                return @"";
            }
        };
    }
}

- (void)setSupportDelete:(bool)supportDelete {
    _supportDelete = supportDelete;
    if (!self.supportDelete && self.supportRearranging) {
        self.supportRearranging = false;
        NSLog(@"Rearranging Disabled!");
    }
}

- (void)setSupportRearranging:(bool)supportRearranging {
    if (self.supportDelete && !self.showSectionIndex) {
        _supportRearranging = supportRearranging;
    } else {
        NSLog(@"Rearranging Disabled!");
    }
}

- (void)setShowSectionIndex:(bool)showSectionIndex {
    _showSectionIndex = showSectionIndex;
    if (self.showSectionIndex && self.supportRearranging) {
        self.supportRearranging = false;
        NSLog(@"Rearranging Disabled!");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerForCellReuseIdentifier];
}

- (void)registerForCellReuseIdentifier {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.dataSource objectAtIndexPath:indexPath];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return self.supportDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.dataSource removeObjectAtIndexPath:indexPath];
        if ([self.dataSource removeSectionIfEmpty:indexPath.section]) {
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        } else {
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.dataSource objectAtIndexPath:fromIndexPath];
    [self.dataSource removeObjectAtIndexPath:fromIndexPath];
    [self.dataSource insertObject:object atIndexPath:toIndexPath];
    if ([self.dataSource removeSectionIfEmpty:fromIndexPath.section]) {
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:fromIndexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    }
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return self.supportRearranging;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.showSectionIndex) {
        return [self.name(self.dataSource[section].firstObject) sectionTitle];
    } else {
        return nil;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.showSectionIndex) {
        NSMutableArray *sectionIndexTitles = [NSMutableArray new];
        for (NSMutableArray *array in self.dataSource) {
            [sectionIndexTitles addObject:[self.name(array.firstObject) sectionTitle]];
        }
        return sectionIndexTitles;
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

@end
