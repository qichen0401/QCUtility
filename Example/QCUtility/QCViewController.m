//
//  QCViewController.m
//  QCUtility
//
//  Created by Qi Chen on 11/29/2016.
//  Copyright (c) 2016 Qi Chen. All rights reserved.
//

#import "QCViewController.h"
#import "QCUtility.h"

@interface QCViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeiv;

@end

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage *img = [UIImage imageWithQRCodeInputMessage:@"hai" size:CGSizeMake(200, 200)];
    
    
//    self.qrcodeiv.image = [UIImage imageWithQRCodeInputMessage:@"hai" size:CGSizeMake(200, 200)];
    
    
//    self.qrcodeiv.image = [UIImage imageWithCGImage:img.CGImage];
    
//    self.qrcodeiv.image = [UIImage imageWithData:UIImageJPEGRepresentation(img, 1.0)];
    
    
//    [UIImageJPEGRepresentation(img, 1.0) writeToFile:[NSFileManager pathOfDocumentDirectoryWith:@"qrcodeImage"] atomically:YES];
//    UIImage *image = [UIImage imageWithContentsOfFile:[NSFileManager pathOfDocumentDirectoryWith:@"qrcodeImage"]];
    
//    UIImage *a = [UIImage imageWithData:UIImageJPEGRepresentation(img, 1.0)];
    
    
    
    self.qrcodeiv.image = [self changeWhiteColorTransparent:img];
    
//    self.qrcodeiv.image = [UIImage imageWithCGImage:self.qrcodeiv.image.CGImage];
//    self.qrcodeiv.image = [UIImage imageWithCGImage:img.CGImage];
}



-(UIImage *)changeWhiteColorTransparent: (UIImage *)image
{
    CGImageRef rawImageRef=image.CGImage;
    
    
    CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(rawImageRef);
    
    
    int a = CGColorSpaceGetNumberOfComponents(colorSpaceRef);
    
    
    //    const CGFloat colorMasking[6] = {222, 255, 222, 255, 222, 255};
    const CGFloat colorMasking[6] = {0, 10, 0, 10, 0, 10};
    
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, colorMasking);
    
//    return [UIImage imageWithCGImage:maskedImageRef];
    
    {
        //if in iphone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    }
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
