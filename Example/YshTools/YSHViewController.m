//
//  YSHViewController.m
//  YshTools
//
//  Created by 994701002@qq.com on 03/16/2022.
//  Copyright (c) 2022 994701002@qq.com. All rights reserved.
//

#import "YSHViewController.h"
#import "GFButton.h"
@interface YSHViewController ()

@end

@implementation YSHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    GFButton *btn = [GFButton buttonWithType:UIButtonTypeCustom];
    btn.imagePosition = GFUIButtonImagePositionRight;
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"study_coin"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 100, 30);
    
    [self.view addSubview:btn];
}



@end
