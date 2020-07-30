//
//  NSString+LTRex.m
//  LTTools
//
//  Created by yelon on 16/4/6.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "NSString+LTRex.h"

@implementation NSString (LTRex)

- (BOOL)evaluate:(NSString *)rex{
    
    if (LT_IsEmptyString(self)) {
        
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", rex];
    
    return [predicate evaluateWithObject:self];
}
//包含数字
- (BOOL)lt_containNumber{
    
    NSString *rex = @"^.*\\d+.*$";
    
    return [self evaluate:rex];
}
//包含大写字母
- (BOOL)lt_containcUppercaseLetter{
    
    NSString *rex = @"^.*[A-Z]+.*$";
    
    return [self evaluate:rex];
}
//包含小写字母
- (BOOL)lt_containcLowercaseLetter{
    
    NSString *rex = @"^.*[a-z]+.*$";
    
    return [self evaluate:rex];
}
//包含字母
- (BOOL)lt_containcLetters{
    
    NSString *rex = @"^.*[a-zA-Z]+.*$";
    
    return [self evaluate:rex];
}
//是否包含中文
- (BOOL)lt_containCN{
    
    NSString *rex = @".*[\\u4e00-\\u9fa5\\ue863\\u4dae]+.*";
    
    return [self evaluate:rex];
}
//密码:（8-16）位字符
- (BOOL)lt_vaidPassword{

    return [self lt_isVaidPassword];
}
//密码:（8-16）位字符
- (BOOL)lt_isVaidPassword{
    
    return [self lt_isVaidPassword:8 toLength:16];
}
//密码:字符 length-toLength
- (BOOL)lt_isVaidPassword:(NSUInteger)length
                 toLength:(NSUInteger)toLength{
    NSString *rex = @"^(?=.*[0-9])(?=.*[a-zA-Z])([A-Z]|[a-z]|[0-9]|[!@#$%%^&*()'\"=_:;?~`|+-\\\\/\\[\\]{},.<>€￡￥·])";
    
    if (toLength == 0) {
        
        rex = [NSString stringWithFormat:@"%@{%@,}$",rex,LT_FilterString(@(length))];
    }
    else if (length == toLength) {
        
        rex = [NSString stringWithFormat:@"%@{%@}$",rex,LT_FilterString(@(length))];
    }
    else if (length < toLength) {
        
        rex = [NSString stringWithFormat:@"%@{%@,%@}$",rex,LT_FilterString(@(length)),LT_FilterString(@(toLength))];
    }
    else {
        
        rex = [NSString stringWithFormat:@"%@{%@,%@}$",rex,LT_FilterString(@(toLength)),LT_FilterString(@(length))];
    }
    
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//银行卡号
- (BOOL)lt_isBankCardNumber{
    NSString *rex = @"^([0-9]{14,21})$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//银行卡有效期
- (BOOL)lt_isCardDate{
    
    NSString *rex = @"^([0][1-9]|[1][0-2])([1][6-9]|[2][0-9])$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//非虚拟手机号校验
- (BOOL)lt_isPhoneNumberString{
    
    /*
     移动号段：
     13[4-9]、147、15([0-2]|[7-9])、17[28]、18([2-4]|[7-8])、198、147（数据卡号段）//1705（虚拟运营商移动号段）
     联通号段：
     13[0-2]、145（数据卡号段）、15[56]、17[156]、18[56]、166//1709（虚拟运营商联通号段）
     电信号段：
     133、1349（卫星通信）、149、153、17[37]、18[019]、199//1700（虚拟运营商电信号段）
     */
    
    NSString * MOBILE = @"^1(3[0-9]|4[5679]|5[0-9]|6[56]]|7[12356789]|8[0-9]|9[189])\\d{8}$";
    
    //中国移动：China Mobile
    NSString * CM = @"^1(34[0-8]|(3[5-9]|47|5[0127-9]|65|8[2-478]|7[28]|98)\\d)\\d{7}$";
    
    //中国联通：China Unicom
    NSString * CU = @"^1(3[0-2]|45|5[56]|66|8[56]|7[156])\\d{8}$";
    
    //中国电信：China Telecom
    NSString * CT = @"^1((33|53|8[019]|7[347]|49|9[19]])[0-9]|349)\\d{7}$";
    
    if ([self evaluate:MOBILE]
        || [self evaluate:CM]
        || [self evaluate:CU]
        || [self evaluate:CT]){
        
        return YES;
    }
    else {
        
        return NO;
    }
}

//虚拟号段校验
- (BOOL)lt_isPhoneVirtualNumberString{
    
    //虚拟号段 170
    NSString *virtualNumber = @"^170\\d{8}$";
    
    if ([self evaluate:virtualNumber]){
        
        return YES;
    }
    else {
        
        return NO;
    }
}

//手机号段校验
- (BOOL)lt_isPhoneNumberStringContainVirtualNumber{

    BOOL result  = [self lt_isNumberString]||[self lt_isPhoneVirtualNumberString];
    return result;
}
//mail地址格式检查
- (BOOL)lt_isEmailString{
    
    NSString *rex = @"^\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//身份证号
- (BOOL)lt_isIDCardNumber{
    
    if ([self length]==15) {
        
        return [self lt_isIDCardNumber15];
    }
    else if ([self length]==18) {
        
        return [self lt_isIDCardNumber18];
    }
    else{
        
        return NO;
    }
}
//15位身份证号
- (BOOL)lt_isIDCardNumber15{
    
    NSString *rex = @"^[1-9]\\d{7}((0[1-9])|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//18位身份证号
- (BOOL)lt_isIDCardNumber18{
    
    NSString *rex = @"^\\d{10}((0[1-9])|(1[0-2]))((0[1-9])|([1-2]\\d)|(3[0-1]))\\d{3}([0-9]|X)$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//是否为数学数据
- (BOOL)lt_isMathsNumber{
    
    NSString *rex = @"^(\\+|-)?\\d+(\\.\\d+)?$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//是否为正整数
- (BOOL)lt_isMathsNumberIntegerString{
    
    NSString *rex = @"^[1-9]\\d*$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

//全数字字符串
- (BOOL)lt_isNumberString{
    
    NSString *rex = @"^\\d+$";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//全数字字符串 限定长度
- (BOOL)lt_isNumberString:(NSUInteger)length{

    return [self lt_isNumberString:length toLength:length];
}
//全数字字符串 限定长度 length-toLength
- (BOOL)lt_isNumberString:(NSUInteger)length
                 toLength:(NSUInteger)toLength{
    NSString *rex = @"";
    
    if (toLength == 0) {
        
        rex = [NSString stringWithFormat:@"^\\d{%@,}$",LT_FilterString(@(0))];
    }
    else if (length == toLength) {
        
        rex = [NSString stringWithFormat:@"^\\d{%@}$",LT_FilterString(@(length))];
    }
    else if (length < toLength) {
        
        rex = [NSString stringWithFormat:@"^\\d{%@,%@}$",LT_FilterString(@(length)),LT_FilterString(@(toLength))];
    }
    else {
        
        rex = [NSString stringWithFormat:@"^\\d{%@,%@}$",LT_FilterString(@(toLength)),LT_FilterString(@(length))];
    }
    
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//验证中文
- (BOOL)lt_isChineseNameString{
    
    NSString *rex = [NSString stringWithFormat:@"^([\\u4e00-\\u9fa5\\ue863\\u4dae])+·?([\\u4e00-\\u9fa5\\ue863\\u4dae])+(·[\\u4e00-\\u9fa5\\ue863\\u4dae]+)*$"];
    BOOL vaild = [self evaluate:rex];
    return vaild;
}
//ip
- (BOOL)lt_isIpString{
    
    NSString *rex = @"\\d{1,3}(.\\d{1,3}){3}";
    BOOL vaild = [self evaluate:rex];
    return vaild;
}

@end
