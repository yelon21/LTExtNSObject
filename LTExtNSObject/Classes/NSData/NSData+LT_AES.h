//
//  NSData+LT_AES.h
//  LTExtNSObject
//
//  Created by yelon on 2018/12/4.
//

#import <Foundation/Foundation.h>
//仅限 ecb PKCS7Padding

@interface NSData (LT_AES)

- (NSData *)lt_aes256EncryptWithKey:(NSString *)key;

- (NSData *)lt_aes256DecryptWithKey:(NSString *)key;
@end
