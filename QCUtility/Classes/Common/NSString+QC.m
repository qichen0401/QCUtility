//
//  NSString+QC.m
//  Pods
//
//  Created by Qi Chen on 11/29/16.
//
//

#import "NSString+QC.h"

@implementation NSString (QC)

- (NSString *)pinyinString {
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripCombiningMarks, NO);
    return string;
}

@end
