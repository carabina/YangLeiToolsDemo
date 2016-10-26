//
//  BaseViewController.m
//  DEMO
//
//  Created by yl on 16/6/8.
//  Copyright © 2016年 yl. All rights reserved.
//

#import "YLBaseViewController.h"
#import "YLSystemHeader.h"

@interface YLBaseViewController ()

@end

@implementation YLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navcBackGImage"] forBarMetrics:UIBarMetricsDefault];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;

    
    //返回按钮
    _backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBut.frame = CGRectMake(0,5*k_height_scale, 54*k_width_scale, 30*k_height_scale);
    _backBut.backgroundColor = [UIColor redColor];
    [_backBut addTarget:self action:@selector(clickBackBut) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBut];
    
    
    
    //导航栏中间的标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70*k_width_scale, 0, 180*k_width_scale, 40*k_height_scale)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:18.0*k_width_scale];
    self.navigationItem.titleView = _titleLabel;



}





- (void)clickBackBut
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
