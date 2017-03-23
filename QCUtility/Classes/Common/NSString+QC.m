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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [predicate evaluateWithObject:self];
    
//    NSError *error;
//    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
//    NSRange rangeOfFirstMatch = [regularExpression rangeOfFirstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
//    return NSEqualRanges(rangeOfFirstMatch, NSMakeRange(0, self.length));
}

- (NSString *)pinyinString {
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformToLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripCombiningMarks, NO);
    return string;
}

+ (NSString *)stringWithJSONObject:(id)obj {
    if ([NSJSONSerialization isValidJSONObject:obj]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    } else {
        return  @"";
    }
}

@end
