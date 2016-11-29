//
//  UIImage+QC.h
//  QRCodeDemo
//
//  Created by Qi Chen on 11/28/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QC)

- (UIImage *)imageScaleToSize:(CGSize)size;
- (UIImage *)imageScaleToSize:(CGSize)size interpolationQuality:(CGInterpolationQuality)quality;

@end
