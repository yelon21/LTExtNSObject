//
//  NSDictionary+LTCommon.m
//  Pods
//
//  Created by yelon on 16/12/14.
//
//

#import "NSDictionary+LTCommon.h"

@implementation NSDictionary (LTCommon)

- (BOOL)lt_isEmpty{
    
    if (self == nil || ![self isKindOfClass:[NSDictionary class]]) {
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
