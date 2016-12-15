//
//  NSArray+LTCommon.m
//  Pods
//
//  Created by yelon on 16/12/14.
//
//

#import "NSArray+LTCommon.h"

@implementation NSArray (LTCommon)

- (BOOL)lt_isEmpty{
    
    if (self == nil || ![self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    
    if ([self count] > 0) {
        
        return NO;
    }
    else {
        
        return YES;
    }
}

@end
