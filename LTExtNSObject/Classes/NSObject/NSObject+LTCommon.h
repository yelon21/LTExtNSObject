//
//  NSObject+LTCommon.h
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LTCommon)

-(NSDictionary *)propertyDictionary;
+ (BOOL)LT_isValidObj:(NSObject *)obj;

+ (void)clearContentInMemory:(NSObject *)obj;
@end
