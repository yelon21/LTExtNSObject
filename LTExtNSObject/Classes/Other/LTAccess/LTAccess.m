//
//  LTAccess.m
//  LTExtNSObject
//
//  Created by 龙 on 2020/8/3.
//

#import "LTAccess.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>

@implementation LTAccess

+ (NSString *)LT_AccessMessage:(LTAccessStatus)status{
    
    switch (status) {
        case LTAccessStatusAuthorized:
            return @"已授权";
        case LTAccessStatusNotDetermined:
            return @"未授权";
        default:
            return @"未授权";
    }
}

// 麦克风访问权限状态
+ (LTAccessStatus)LT_AccessToAudioStatus{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    LTAccessStatus status = LTAccessStatusNotDetermined;
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            status = LTAccessStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            status = LTAccessStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            status = LTAccessStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            status = LTAccessStatusAuthorized;
            break;
    }
    return status;
}

// 麦克风访问权限
+ (void)LT_AccessToAudioCheck:(void (^)(BOOL granted))handler{
    
    if (handler) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            
            handler(granted);
        }];
    }
}

// 相机访问权限状态
+ (LTAccessStatus)LT_AccessToVideoStatus{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    LTAccessStatus status = LTAccessStatusNotDetermined;
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            status = LTAccessStatusNotDetermined;
            break;
        case AVAuthorizationStatusRestricted:
            status = LTAccessStatusRestricted;
            break;
        case AVAuthorizationStatusDenied:
            status = LTAccessStatusDenied;
            break;
        case AVAuthorizationStatusAuthorized:
            status = LTAccessStatusAuthorized;
            break;
    }
    return status;
}

// 相机访问权限
+ (void)LT_AccessToVideoCheck:(void (^)(BOOL granted))handler{
    
    if (handler) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            handler(granted);
        }];
    }
}

// 相册访问权限状态
+ (LTAccessStatus)LT_AccessToPhotosStatus{
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    LTAccessStatus status = LTAccessStatusNotDetermined;
    switch (authStatus) {
        case PHAuthorizationStatusNotDetermined:
            status = LTAccessStatusNotDetermined;
            break;
        case PHAuthorizationStatusRestricted:
            status = LTAccessStatusRestricted;
            break;
        case PHAuthorizationStatusDenied:
            status = LTAccessStatusDenied;
            break;
        case PHAuthorizationStatusAuthorized:
            status = LTAccessStatusAuthorized;
            break;
    }
    return status;
}

// 相册访问权限
+ (void)LT_AccessToPhotosCheck:(void (^)(BOOL granted))handler{
    
    if (handler) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                handler(YES);
            } else {
                handler(NO);
            }
        }];
    }
}

// 定位访问权限状态
+ (LTAccessStatus)LT_AccessToLocationStatus{
    
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    LTAccessStatus status = LTAccessStatusNotDetermined;
    switch (authStatus) {
        case kCLAuthorizationStatusNotDetermined:
            status = LTAccessStatusNotDetermined;
            break;
        case kCLAuthorizationStatusRestricted:
            status = LTAccessStatusRestricted;
            break;
        case kCLAuthorizationStatusDenied:
            status = LTAccessStatusDenied;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
            status = LTAccessStatusAuthorized;
            break;
    }
    return status;
}

// 通知访问权限状态
+ (LTAccessStatus)LT_AccessToNotificationStatus{
    
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    UIUserNotificationType authStatus = settings.types;
    
    if (authStatus == UIUserNotificationTypeNone) {
        
        return LTAccessStatusDenied;
    }
    
    return LTAccessStatusAuthorized;
}

@end
