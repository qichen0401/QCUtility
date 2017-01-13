//
//  StoreManager.h
//  Pods
//
//  Created by Qi Chen on 1/13/17.
//
//

// Non-Consumable only

/*
 to do:
 1. load from bundle file
 */

/*
 Help:
 1.
 application:didFinishLaunchingWithOptions:
 [[StoreManager sharedManager] addTransactionObserver];
 
 2.
 applicationWillTerminate:
 [[StoreManager sharedManager] removeTransactionObserver];
 
 3.
 validateProductIdentifiers
 
 4.
 ProductRequestNotification
 
 5.
 UnlockFunctionalityNotification
 */

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

extern NSString * const ProductRequestNotification;
extern NSString * const UnlockFunctionalityNotification;

@interface StoreManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) NSArray<SKProduct *> *products;
@property (strong, nonatomic) NSDictionary<NSString *, SKProduct *> *productsDictionary;
@property (nonatomic, getter=isReady) BOOL ready;

+ (instancetype)sharedManager;

- (void)addTransactionObserver;
- (void)removeTransactionObserver;

- (void)validateProductIdentifiers:(NSArray *)productIdentifiers;
- (void)buy:(SKProduct *)product;
- (void)buyProductWithIdentifier:(NSString *)identifier;
- (void)restore;

@end
