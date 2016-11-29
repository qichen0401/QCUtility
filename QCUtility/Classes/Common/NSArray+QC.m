//
//  NSArray+QC.m
//  TableViewDemo
//
//  Created by Qi Chen on 11/18/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "NSArray+QC.h"

@implementation NSArray (QC)

- (id)deepMutableCopy {
    NSMutableArray *array = [NSMutableArray new];
    for (id object in self) {
        if ([object isKindOfClass:[NSArray class]]) {
            [array addObject:[object deepMutableCopy]];
        } else {
            [array addObject:[object copy]];
        }
    }
    return array;
}

@end
