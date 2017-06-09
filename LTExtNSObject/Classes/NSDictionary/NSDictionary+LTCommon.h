//
//  NSDictionary+LTCommon.h
//  Pods
//
//  Created by yelon on 16/12/14.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+LTCommon.h"

@interface NSDictionary (LTCommon)

@end

#ifdef __cplusplus
extern "C" {
#endif
    BOOL LT_isEmptyDictionary(NSObject *obj);
#ifdef __cplusplus
}
#endif
