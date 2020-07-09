//
//  NSString+LTDES.h
//  YJPayManager
//
//  Created by yelon on 16/10/26.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTDES)

- (NSString *)lt_encryptDESWithKey:(NSString *)deskey;
//解密
- (NSString *)lt_decryptDESWithKey:(NSString*)deskey;

- (NSString *)lt_encrypt3DESWithKey:(NSString *)deskey;

//解密
- (NSString *)lt_decrypt3DESWithKey:(NSString*)deskey;
@end
