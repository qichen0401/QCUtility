//
//  NSString+QC.h
//  Pods
//
//  Created by Qi Chen on 11/29/16.
//
//

#import <Foundation/Foundation.h>

@interface NSString (QC)

- (BOOL)isMatchRegularExpression:(NSString *)pattern;
- (NSString *)pinyinString;
+ (NSString *)stringWithJSONObject:(id)obj;

@end
