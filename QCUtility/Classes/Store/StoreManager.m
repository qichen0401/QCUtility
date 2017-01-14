//
//  StoreManager.m
//  Pods
//
//  Created by Qi Chen on 1/13/17.
//
//

#import "StoreManager.h"

NSString * const ProductRequestNotification = @"ProductRequestNotification";
NSString * const UnlockFunctionalityNotification = @"UnlockFunctionalityNotification";

@interface StoreManager ()

@property (strong, nonatomic) SKProductsRequest *productsRequest;
//@property (strong, nonatomic) SKReceiptRefreshRequest *receiptRefreshRequest;

@end

@implementation StoreManager

+ (instancetype)sharedManager {
    static StoreManager *sharedManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [StoreManager new];
    });
    return sharedManager;
}

+ (BOOL)canMakePayments {
    return [SKPaymentQueue canMakePayments];
}

- (void)addTransactionObserver {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)removeTransactionObserver {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver: self];
}

- (void)validateProductIdentifiers:(NSArray *)productIdentifiers {
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:productIdentifiers]];
    
    // Keep a strong reference to the request.
    self.productsRequest = productsRequest;
    productsRequest.delegate = self;
    [productsRequest start];
}

- (void)validateProductIdentifiersWithFileName:(NSString *)fileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"plist"];
    NSArray *productIdentifiers = [NSArray arrayWithContentsOfURL:url];
    [self validateProductIdentifiers:productIdentifiers];
}

- (void)setProducts:(NSArray<SKProduct *> *)products {
    _products = products;
    self.productsDictionary = nil;
}

- (NSDictionary *)productsDictionary {
    if (!_productsDictionary) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        for (SKProduct *product in self.products) {
            dic[product.productIdentifier] = product;
        }
        _productsDictionary = dic;
    }
    return _productsDictionary;
}

- (void)buy:(SKProduct *)product {
    [[SKPaymentQueue defaultQueue] addPayment:[SKPayment paymentWithProduct:product]];
}

- (void)buyProductWithIdentifier:(NSString *)identifier {
    [self buy:self.productsDictionary[identifier]];
}

- (void)restore {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
//    SKReceiptRefreshRequest *receiptRefreshRequest = [SKReceiptRefreshRequest new];
//    
//    // Keep a strong reference to the request.
//    self.receiptRefreshRequest = receiptRefreshRequest;
//    receiptRefreshRequest.delegate = self;
//    [receiptRefreshRequest start];
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [self persistTransaction:transaction];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UnlockFunctionalityNotification object:self userInfo:@{@"productIdentifier" : transaction.payment.productIdentifier}];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)persistTransaction:(SKPaymentTransaction *)transaction {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:true forKey:transaction.payment.productIdentifier];
    [userDefaults synchronize];
}

#pragma mark - SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    self.products = response.products;
    
    for (NSString *invalidIdentifier in response.invalidProductIdentifiers) {
        // Handle any invalid product identifiers.
        NSLog(@"invalid product identifier: %@", invalidIdentifier);
    }
    
    self.ready = true;
    [[NSNotificationCenter defaultCenter] postNotificationName:ProductRequestNotification object:self];
}

#pragma mark - SKPaymentTransactionObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
                // Call the appropriate custom method for the transaction state.
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"purchasing");
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"deferred");
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"failed");
                NSLog(@"%@", [transaction.error localizedDescription]);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"purchased");
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"restored");
                [self completeTransaction:transaction];
                break;
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;
        }
    }
}

@end
