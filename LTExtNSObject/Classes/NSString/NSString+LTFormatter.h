//
//  NSString+LTFormatter.h
//  Pods
//
//  Created by yelon on 16/12/1.
//
//

#import <Foundation/Foundation.h>
#import "NSString+LTCommon.h"

@interface NSString (LTFormatter)
//过滤掉string中的字符
- (NSString *)lt_stringByFilterCharactersInString:(NSString *)string;
//保留string中的字符
- (NSString *)lt_stringBySaveCharactersInString:(NSString *)string;
//过滤掉setToRemove中的字符
- (NSString *)lt_stringByFilterCharacters:(NSCharacterSet *)setToRemove;

//number to ￥123.00
+ (NSString *)LT_amountRMBStringByNumber:(NSNumber *)number;
//￥123.00 to number
- (NSNumber *)lt_numberByAmountRMBString;

//abc1234512 to abc1 2345 12
- (NSString *)lt_cardNoStringWithSpace;
//abc1 2345 12 to abc1234512
- (NSString *)lt_cardNoStringWithoutSpace;
@end
