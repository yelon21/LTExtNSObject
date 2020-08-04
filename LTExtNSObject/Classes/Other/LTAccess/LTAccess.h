//
//  LTAccess.h
//  LTExtNSObject
//
//  Created by 龙 on 2020/8/3.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LTAccessStatus) {
    LTAccessStatusNotDetermined = 0,
    LTAccessStatusRestricted    = 1,
    LTAccessStatusDenied        = 2,
    LTAccessStatusAuthorized    = 3
};

NS_ASSUME_NONNULL_BEGIN

@interface LTAccess : NSObject

+ (NSString *)LT_AccessMessage:(LTAccessStatus)status;

// 麦克风访问权限状态
+ (LTAccessStatus)LT_AccessToAudioStatus;

// 麦克风访问权限
+ (void)LT_AccessToAudioCheck:(void (^)(BOOL granted))handler;

// 相机访问权限状态
+ (LTAccessStatus)LT_AccessToVideoStatus;

// 相机访问权限
+ (void)LT_AccessToVideoCheck:(void (^)(BOOL granted))handler;

// 相册访问权限状态
+ (LTAccessStatus)LT_AccessToPhotosStatus;

// 相册访问权限
+ (void)LT_AccessToPhotosCheck:(void (^)(BOOL granted))handler;

// 定位访问权限状态
+ (LTAccessStatus)LT_AccessToLocationStatus;

// 通知访问权限状态
+ (LTAccessStatus)LT_AccessToNotificationStatus;


@end

NS_ASSUME_NONNULL_END
