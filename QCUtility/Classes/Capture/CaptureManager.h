//
//  CaptureManager.h
//  CameraDemo
//
//  Created by Qi Chen on 11/30/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CaptureManager : NSObject <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

typedef NS_ENUM(NSUInteger, CaptureOutputType) {
    CaptureOutputTypeMetadataFace,
    CaptureOutputTypeMetadataQRCode,
    CaptureOutputTypeVideoData,
};

//void (^handleQRCode)(NSString *) = ^(NSString *stringValue) {};
@property (strong, nonatomic) void (^handleQRCode)(NSString *);

- (void)configureWithView:(UIView *)view type:(CaptureOutputType)type error:(NSError **)error;

- (void)startRunning;
- (void)stopRunning;

@end
