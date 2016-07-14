//
//  LYViewController.m
//  LTExtNSObject
//
//  Created by yelon21 on 07/14/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import "NSObject+LTCommon.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
