//
//  NSString+LTFormatter.m
//  Pods
//
//  Created by yelon on 16/12/1.
//
//

#import "NSString+LTFormatter.h"

@implementation NSString (LTFormatter)

- (NSString *)lt_stringByFilterCharactersInString:(NSString *)string{

    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    
    NSString *sourceString = self;
    
    string = LT_FilterString(string);
    
    NSCharacterSet *setToRemove = [NSCharacterSet characterSetWithCharactersInString:string];
    
    return [sourceString lt_stringByFilterCharacters:setToRemove];
}

- (NSString *)lt_stringBySaveCharactersInString:(NSString *)string{
    
    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    
    NSString *sourceString = self;
    
    string = LT_FilterString(string);
    
    NSCharacterSet *setToRemove = [[NSCharacterSet characterSetWithCharactersInString:string]
                                   invertedSet];
    
    return [sourceString lt_stringByFilterCharacters:setToRemove];
}

- (NSString *)lt_stringByFilterCharacters:(NSCharacterSet *)setToRemove{
    
    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    
    NSString *sourceString = self;
    
    NSString *newString = [sourceString stringByTrimmingCharactersInSet:setToRemove];
    
    return newString;
}

+ (NSString *)LT_amountRMBStringByNumber:(NSNumber *)number{
    
    if (number == nil || ![number isKindOfClass:[NSNumber class]]) {
        
        return @"";
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSString *string = [formatter stringFromNumber:number];
    
    return string;
}

- (NSNumber *)lt_numberByAmountRMBString{
    
    if (LT_IsEmptyString(self)) {
        
        return @(0);
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_Hans_CN"]];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    NSNumber *number = [formatter numberFromString:self];
    
    return number;
}

- (NSString *)lt_cardNoStringWithSpace{

    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    NSString *tmp = [self stringByReplacingOccurrencesOfString:@" "
                                                    withString:@""];
    
    NSInteger count = ceil([tmp length]/4.0);
    
    NSMutableArray *compnents = [[NSMutableArray alloc]init];
    
    for (NSInteger i = 0; i < count; i++) {
        
        if ([tmp length]>4) {
            
            [compnents addObject:[tmp substringToIndex:4]];
            tmp = [tmp substringFromIndex:4];
        }
        else{
            
            [compnents addObject:tmp];
        }
    }
    
    return [compnents componentsJoinedByString:@" "];
}

- (NSString *)lt_cardNoStringWithoutSpace{
    
    if (LT_IsEmptyString(self)) {
        
        return @"";
    }
    NSString *tmp = [self stringByReplacingOccurrencesOfString:@" "
                                                    withString:@""];
    
    return tmp;
}
@end
