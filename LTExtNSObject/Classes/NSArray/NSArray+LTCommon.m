//
//  NSArray+LTCommon.m
//  Pods
//
//  Created by yelon on 16/12/14.
//
//

#import "NSArray+LTCommon.h"

@implementation NSArray (LTCommon)


@end

BOOL LT_isEmptyArray(NSObject *obj){
    
    BOOL isEmpty = ![NSArray LT_isValidObj:obj];
    
    if (!isEmpty) {
        
        isEmpty = [(NSArray *)obj count] == 0;
    }
    
    return isEmpty;
}
