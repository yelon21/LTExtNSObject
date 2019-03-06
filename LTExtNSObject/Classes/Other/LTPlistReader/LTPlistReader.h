//
//  LTPlistReader.h
//  YJNew
//
//  Created by yelon on 16/3/5.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTPlistReader : NSObject

+ (id)LT_getBundlePlist:(NSString *)plistName;
+ (id)LT_getObjectForKey:(NSString *)keyName plistName:(NSString *)plistName;

+ (id)LT_objectFromPath:(NSString *)path;

+ (BOOL)LT_savePlist:(id)plist toPath:(NSString *)toPath;
@end
