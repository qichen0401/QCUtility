//
//  NSFileManager+QC.m
//  Pods
//
//  Created by Qi Chen on 12/18/16.
//
//

#import "NSFileManager+QC.h"

@implementation NSFileManager (QC)

+ (NSURL *)documentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

+ (NSString *)pathOfDocumentDirectoryWith: (NSString *)pathComponent {
    return [[[NSFileManager documentDirectory] URLByAppendingPathComponent:pathComponent] path];
}

@end
