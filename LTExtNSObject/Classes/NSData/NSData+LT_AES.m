//
//  NSData+LT_AES.m
//  LTExtNSObject
//
//  Created by yelon on 2018/12/4.
//

#import "NSData+LT_AES.h"
#import "NSString+LTCommon.h"
#import <CommonCrypto/CommonCryptor.h>

@implementation NSData (LT_AES)

- (NSData *)lt_aes256EncryptWithKey:(NSString *)key {
    
    if (!self) {
        
        return nil;
    }
    
    key = LT_FilterString(key);
    
    if (key.length == 0) {
        
        return nil;
    }
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytes:buffer length:numBytesEncrypted];
        free(buffer);
        return resultData;
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData *)lt_aes256DecryptWithKey:(NSString *)key {
    
    if (!self) {
        
        return nil;
    }
    
    key = LT_FilterString(key);
    
    if (key.length == 0) {
        
        return nil;
    }
    
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytes:buffer length:numBytesDecrypted];
        free(buffer);
        return resultData;
    }
    
    free(buffer);
    return nil;
}


@end
