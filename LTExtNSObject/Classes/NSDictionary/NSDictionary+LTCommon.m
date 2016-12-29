//
//  NSDictionary+LTCommon.m
//  Pods
//
//  Created by yelon on 16/12/14.
//
//

#import "NSDictionary+LTCommon.h"

@implementation NSDictionary (LTCommon)

@end

BOOL LT_isEmptyDictionary(NSObject *obj){
    
    BOOL isEmpty = ![NSDictionary LT_isValidObj:obj];
    
    if (!isEmpty) {
        
        isEmpty = [(NSDictionary *)obj count] == 0;
    }
    
    return isEmpty;
}
