//
//  NSObject+LTCommon.m
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "NSObject+LTCommon.h"
#import "NSObject_define.h"
#import <objc/runtime.h>

@implementation NSObject (LTCommon)

-(NSDictionary *)propertyDictionary{
    
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([self class], &outCount);
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propName];
        if(propValue){
            dict[propName] = propValue;
        }
    }
    free(props);
    return dict;
}

+ (BOOL)LT_isValidObj:(NSObject *)obj{

    if (!obj || ![obj isKindOfClass:[self class]]) {
        
        return NO;
    }
    return YES;
}

+ (void)clearContentInMemory:(NSObject *)obj{
    
    if ([obj isKindOfClass:[NSData class]]) {
        
        unsigned long long address = (unsigned long long)[(NSData *)obj bytes];
        long size = [(NSData *)obj length];
        obj = nil;
        memset((void *)address,0, size);
    }
    else if ([obj isKindOfClass:[NSString class]]){
        
        CFStringRef stringRef = (__bridge CFStringRef)(NSString *)obj;
        int size = (int)[(NSString *)obj lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        
        const void * address  = CFStringGetCStringPtr(stringRef, kCFStringEncodingUTF8);
        if (address == NULL) {
            
            return;
        }
        if ((unsigned long long)address > 0xffffffffff) {
            
            return;
        }
        obj = nil;
        
        memset((void *)address,0, size);
    }
    else{
        
        NSLog(@"object class:%@", NSStringFromClass([obj class]));
    }
}

@end
