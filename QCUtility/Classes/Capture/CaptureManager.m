//
//  CaptureManager.m
//  CameraDemo
//
//  Created by Qi Chen on 11/30/16.
//  Copyright © 2016 Qi Chen. All rights reserved.
//

#import "CaptureManager.h"

@interface CaptureManager ()

@property (strong, nonatomic) AVCaptureSession *session;

@end

@implementation CaptureManager

- (void)configureWithView:(UIView *)view type:(CaptureOutputType)type error:(NSError **)error {
    self.session = [AVCaptureSession new];
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:error];
    if (!input) {
        return;
    }
    if ([self.session canAddInput:input]) {
        [self.session addInput:input];
    }
    
    AVCaptureVideoPreviewLayer *videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    videoPreviewLayer.frame = view.bounds;
    [view.layer addSublayer:videoPreviewLayer];
    
    switch (type) {
        case CaptureOutputTypeMetadataFace: {
            AVCaptureMetadataOutput *metadataOutput = [AVCaptureMetadataOutput new];
            [self addOutput:metadataOutput];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeFace];
            break;
        }
        case CaptureOutputTypeMetadataQRCode: {
            AVCaptureMetadataOutput *metadataOutput = [AVCaptureMetadataOutput new];
            [self addOutput:metadataOutput];
            [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
            break;
        }
        case CaptureOutputTypeVideoData: {
            AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
            [self addOutput:videoDataOutput];
            [videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
            break;
        }
    }
}

- (void)addOutput:(AVCaptureOutput *)output {
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
}

- (void)startRunning {
    [self.session startRunning];
}

- (void)stopRunning {
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([metadataObjects.firstObject isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
        NSLog(@"String Value: %@", metadataObject.stringValue);
        [self.delegate didCaptureQRCodeStringValue:metadataObject.stringValue];
        [self stopRunning];
    }
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}

@end
