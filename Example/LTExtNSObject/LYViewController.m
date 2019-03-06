//
//  LYViewController.m
//  LTExtNSObject
//
//  Created by yelon21 on 07/14/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import "NSObject+LTCommon.h"
#import "NSArray+LTCommon.h"
#import "LTOpenSettings.h"
#import <NSData+LT_AES.h>

@interface LYViewController ()

@property(nonatomic,strong) NSString *fff;
@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fff = @"www";
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"propertyDictionary=%@",[self propertyDictionary]);
    
//    NSArray *list = @[];
//    
//    BOOL empty =  LT_isEmptyArray(list);
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
//    LTOpenAppSettings();
    
    NSString *source = @"12345678901234567";
    
    NSString *key = @"11111111222222223333333344444444";
    
    NSData *sourceData = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encData = [sourceData lt_aes256EncryptWithKey:key];
    
//    NSString *enc64String = [encData base64EncodedStringWithOptions:0];
//
//    NSData *dec64Data = [[NSData alloc]initWithBase64EncodedString:enc64String
//                                                           options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData *decData = [encData lt_aes256DecryptWithKey:key];
    NSString *result = [[NSString alloc]initWithData:decData encoding:NSUTF8StringEncoding];
    
    NSLog(@"result=%@",result);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
