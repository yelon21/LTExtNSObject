//
//  NSString+LTCommon.h
//  Pods
//
//  Created by yelon on 17/1/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (LTCommon)

+ (NSString *)LT_StringJoindByComponents:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION;

- (BOOL)lt_containsString:(NSString *)str;

- (NSString *)lt_maskString;

- (NSString *)lt_maskNameString;

- (NSString *)lt_maskPhoneNumberString;
@end

#ifdef __cplusplus
extern "C" {
#endif
    NSString *LT_FilterString(id obj);
    BOOL LT_IsEmptyString(NSObject *obj);
#ifdef __cplusplus
}
#endif
