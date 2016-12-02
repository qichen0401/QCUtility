//
//  NSString+QC.m
//  Pods
//
//  Created by Qi Chen on 11/29/16.
//
//

#import "NSString+QC.h"

@implementation NSString (QC)

- (BOOL)isMatchRegularExpression:(NSString *)pattern {
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    NSRange rangeOfFirstMatch = [regularExpression rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return !NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0));
}

- (NSString *)pinyinString {
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripCombiningMarks, NO);
    return string;
}

@end
