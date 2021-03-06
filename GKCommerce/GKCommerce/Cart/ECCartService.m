//
//  CartService.m
//  GKCommerce
//
//  Created by 小悟空 on 11/23/14.
//  Copyright (c) 2014 GKCommerce. All rights reserved.
//

#import "ECCartService.h"
#import "Dependency.h"

@implementation ECCartService

- (id)init
{
    self = [super init];
    if (self) {
        self.backend = [[Dependency shared] cartBackend];
        self.backend.delegate = self;
    }
    return self;
}

- (void)fetchCartWithUser:(User *)user
{
    DDLogVerbose(@"CartService featch cart with user %@", user.username);
    [self.backend requestCartWithUser:user];
}

- (void)addItem:(CartItem *)item
{
    [self.backend requestAddItem:item];
}

- (void)updateItem:(CartItem *)item oldQuantity:(NSInteger)anOldQuantity
{
    [self.backend requestUpdateItem:item oldQuantity:anOldQuantity];
}

- (void)removeItem:(CartItem *)item
{
    [self.backend requestRemoveItem:item];
}

- (void)removeItems:(NSArray *)items
{
    for (CartItem *item in items)
        [self removeItem:item];
}

#pragma mark - CartBackendDelegate

- (void)cartBackend:(id<CartBackend>)aCartBackend didAddItem:(CartItem *)item
              error:(NSError *)anError
{
    SEL selector = @selector(cartService:didAddItem:error:);
    if ([self.delegate respondsToSelector:selector])
        [self.delegate cartService:self didAddItem:item error:anError];
}

- (void)cartBackend:(id<CartBackend>)aCartBackend didReceiveCart:(Cart *)cart
              error:(NSError *)anError
{
    [[[App shared] currentUser] setCart:cart];
    SEL selector = @selector(cartService:cart:error:);
    if ([self.delegate respondsToSelector:selector])
        [self.delegate cartService:self cart:cart error:anError];
}

- (void)cartBackend:(id<CartBackend>)aCartBackend didUpdateItem:(CartItem *)item
        oldQuantity:(NSInteger)anOldQuantity error:(NSError *)anError
{
    if (anError)
        item.quantity = anOldQuantity;
    
    SEL selector = @selector(cartService:didUpdateItem:oldQuantity:error:);
    if ([self.delegate respondsToSelector:selector])
        [self.delegate cartService:self didUpdateItem:item
                       oldQuantity:anOldQuantity error:anError];
}

- (void)cartBackend:(id<CartBackend>)aCartBackend didRemoveItem:(CartItem *)item
              error:(NSError *)anError
{
    if (anError)
        return;
    
    [item removeFromList];
    
    SEL selector = @selector(cartService:didRemoveItem:error:);
    if ([self.delegate respondsToSelector:selector])
        [self.delegate cartService:self didRemoveItem:item error:anError];
}
@end
