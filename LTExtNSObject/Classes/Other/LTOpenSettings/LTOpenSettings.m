//
//  LTOpenSettings.m
//  YJNew
//
//  Created by yelon on 16/1/15.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTOpenSettings.h"
#import "NSObject_define.h"
#import <UIKit/UIApplication.h>

void LTOpenAppSettings(){

    if (LT_IOS_Foundation_Before_8) {
        
        LTOpenSettingsURLString(@"prefs:");
    }
    else{
        
        LTOpenSettingsURLString(UIApplicationOpenSettingsURLString);
    }
}

void LTOpenSettingsURLString(NSString *urlString){
    
    if (!urlString || ![urlString isKindOfClass:[NSString class]]) {
        
        return;
    }
    /*
    if (LT_IOS_Foundation_Later_8) {
        
        urlString = UIApplicationOpenSettingsURLString;
    }
     */
    
    NSURL * url = [NSURL URLWithString:urlString];
    //NSLog(@"url==%@",url);
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        //NSLog(@"canOpenURL==%@",url);
        [[UIApplication sharedApplication] openURL:url];
    }
}

