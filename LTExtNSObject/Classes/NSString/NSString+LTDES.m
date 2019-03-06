//
//  NSString+LTDES.m
//  YJPayManager
//
//  Created by yelon on 16/10/26.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTDES.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (LTDES)

/*字符串加密
 *参数
 *plainText : 加密明文
 *key        : 密钥 64位
 */
- (NSString *)lt_encryptDESWithKey:(NSString *)deskey{
    
    NSString *ciphertext = nil;
    NSString *plainText = self;
    
    NSData *textData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    NSUInteger bufferPtrSize = ([textData length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char buffer[bufferPtrSize];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    Byte iv[] = {1,2,3,4,5,6,7,8};
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [deskey UTF8String], kCCKeySizeDES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer, bufferPtrSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data]
                                           encoding:NSUTF8StringEncoding];
    }
    
    return ciphertext;
}

//解密
- (NSString *)lt_decryptDESWithKey:(NSString*)deskey{
    
    NSString *cipherText = self;
    
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    
    NSUInteger bufferPtrSize = ([cipherData length] + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    unsigned char buffer[bufferPtrSize];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [deskey UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          bufferPtrSize,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
@end
