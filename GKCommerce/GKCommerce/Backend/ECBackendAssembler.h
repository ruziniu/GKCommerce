//
//  ECBackendAssembler.h
//  GKCommerce
//
//  Created by 小悟空 on 11/21/14.
//  Copyright (c) 2014 GKCommerce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECBackendAssembler : NSObject

- (NSError *)error:(NSDictionary *)JSON;
- (NSString *)digitalWithString:(NSString *)string;
@end
