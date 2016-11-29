//
//  NSString+UITableViewController.m
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "NSString+UITableViewController.h"
#import "NSString+QC.h"
#import <UIKit/UIKit.h>

@implementation NSString (UITableViewController)

- (NSString *)sectionTitle {
    if (self.length == 0) {
        return nil;
    } else {
        NSString *firstLetter = [[[self pinyinString] substringToIndex:1] uppercaseString];
        NSArray *sectionTitles = [[UILocalizedIndexedCollation currentCollation] sectionTitles];
        if ([sectionTitles containsObject:firstLetter]) {
            return firstLetter;
        } else {
            return sectionTitles.lastObject;
        }
    }
}

@end
