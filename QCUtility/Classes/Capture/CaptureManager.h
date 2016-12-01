//
//  CaptureManager.h
//  CameraDemo
//
//  Created by Qi Chen on 11/30/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, CaptureOutputType) {
    CaptureOutputTypeMetadataFace,
    CaptureOutputTypeMetadataQRCode,
    CaptureOutputTypeVideoData,
};

@protocol CaptureManagerDelegate;

@interface CaptureManager : NSObject <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (weak, nonatomic) id<CaptureManagerDelegate> delegate;

- (void)configureWithView:(UIView *)view type:(CaptureOutputType)type error:(NSError **)error;

- (void)startRunning;
- (void)stopRunning;

@end

@protocol CaptureManagerDelegate <NSObject>

- (void)captureManager:(CaptureManager *)captureManager handleQRCodeStringValue:(NSString *)stringValue;

@end
