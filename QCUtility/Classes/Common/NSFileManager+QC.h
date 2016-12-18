//
//  NSFileManager+QC.h
//  Pods
//
//  Created by Qi Chen on 12/18/16.
//
//

#import <Foundation/Foundation.h>

@interface NSFileManager (QC)

+ (NSURL *)documentDirectory;
+ (NSString *)pathOfDocumentDirectoryWith: (NSString *)pathComponent;

@end
