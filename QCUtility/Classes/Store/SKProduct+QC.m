//
//  SKProduct+QC.m
//  Pods
//
//  Created by Qi Chen on 1/13/17.
//
//

#import "SKProduct+QC.h"

@implementation SKProduct (QC)

- (NSString *)formattedPrice {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.priceLocale];
    NSString *formattedPrice = [numberFormatter stringFromNumber:self.price];
    return formattedPrice;
}

@end
