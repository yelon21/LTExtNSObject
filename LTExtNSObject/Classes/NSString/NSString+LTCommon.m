//
//  NSString+LTCommon.m
//  Pods
//
//  Created by yelon on 17/1/13.
//
//

#import "NSString+LTCommon.h"

@implementation NSString (LTCommon)

NSString *LT_FilterString(id obj){
    
    if (obj == nil) {
        
        return @"";
    }
    
    if ([obj isKindOfClass:[NSString class]]) {
        
        return [NSString stringWithFormat:@"%@",obj];
        
    }else if([obj isKindOfClass:[NSNumber class]]){
        
        return [NSString stringWithFormat:@"%@",obj];
    }
    return @"";
    
}

BOOL LT_IsEmptyString(NSObject *obj){
    
    BOOL isEmpty = YES;
    
    if (!obj || ![obj isKindOfClass:[NSString class]]) {
        
        isEmpty = YES;
    }
    else{
        
        isEmpty = NO;
    }
    
    if (!isEmpty) {
        
        NSString *string = (NSString *)obj;
        
        if ([string length] == 0
            || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
            
            isEmpty = YES;
        }
        else{
            
            isEmpty = NO;
        }
    }
    
    return isEmpty;
}

+ (NSString *)LT_StringJoindByComponents:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION{
    
    NSMutableString *resultString = [[NSMutableString alloc]init];
    
    if (components) {
        
        NSString *arg = LT_FilterString(components);
        
        if(!LT_IsEmptyString(arg)){
            
            [resultString appendString:arg];
        }
        
        va_list params; //定义一个指向个数可变的参数列表指针;
        va_start(params,components);//va_start 得到第一个可变参数地址,
        
        //va_arg 指向下一个参数地址
        while( (arg = va_arg(params,id)) ){
            
            arg = LT_FilterString(arg);
            if(!LT_IsEmptyString(arg)){
                
                [resultString appendString:arg];
            }
        }
        //置空
        va_end(params);
    }
    
    return resultString;
}

- (BOOL)lt_containsString:(NSString *)str{

    if (!self || ![self isKindOfClass:[NSString class]]) {
        
        return NO;
    }
    
    if (!str || ![str isKindOfClass:[NSString class]]) {
        
        return NO;
    }
    
    if ([self rangeOfString:str].location == NSNotFound) {
        
        return NO;
    }
    return YES;
}

- (NSString *)lt_maskString{
    
    NSInteger length = self.length-4;
    
    if (length>0) {
        
        return [self lt_maskString:NSMakeRange(2, length)];
    }
    return self;
}

- (NSString *)lt_maskNameString{
    
    NSInteger length = self.length-1;
    
    if (length>0) {
        
        return [self lt_maskString:NSMakeRange(1, length)];
    }
    return self;
}

- (NSString *)lt_maskPhoneNumberString{

    return [self lt_maskString:NSMakeRange(3, 4)];
}

- (NSString *)lt_maskString:(NSRange)range{
    
    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    
    NSUInteger contentLength = self.length;
    
    NSUInteger rangeLocation = range.location;
    NSUInteger rangeLength = range.length;
    
    if (rangeLength==0 || contentLength < rangeLocation+rangeLength) {
        
        return self;
    }
    
    NSMutableArray *mask = [[NSMutableArray alloc] init];
    
    do {
        [mask addObject:@"*"];
    } while (mask.count < rangeLength);
    
    NSString *des = [self stringByReplacingCharactersInRange:range
                                                  withString:[mask componentsJoinedByString:@""]];
    return des;
}

@end
