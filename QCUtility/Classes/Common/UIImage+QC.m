//
//  UIImage+QC.m
//  QRCodeDemo
//
//  Created by Qi Chen on 11/28/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "UIImage+QC.h"

@implementation UIImage (QC)

+ (UIImage *)imageWithQRCodeInputMessage:(NSString *)inputMessage size:(CGSize)size {
    NSData *inputMessageData = [inputMessage dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator" withInputParameters:@{@"inputMessage":inputMessageData}];
    CIImage *outputImage = filter.outputImage;
    UIImage *image = [[UIImage imageWithCIImage:outputImage] imageScaleToSize:size interpolationQuality:kCGInterpolationNone];
    return image;
}

- (UIImage *)imageScaleToSize:(CGSize)size {
    return [self imageScaleToSize:size interpolationQuality:kCGInterpolationDefault];
}

- (UIImage *)imageScaleToSize:(CGSize)size interpolationQuality:(CGInterpolationQuality)quality {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), quality);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
