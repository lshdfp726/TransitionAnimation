//
//  SecondViewController.m
//  OCNavigation
//
//  Created by 刘松洪 on 2020/7/13.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "SecondViewController.h"
#import "VCAnimationManager.h"
@interface SecondViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) LshInterActive *interactiveTransition;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 200, 200, 100);
    [btn setTitle:@"返回上一层" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    self.navigationController.delegate = [VCAnimationManager shareInstance];
    self.interactiveTransition = [LshInterActive new];
    [self.interactiveTransition setVC:self];
    [VCAnimationManager shareInstance].interactiveTransition = self.interactiveTransition;
}


- (void)back {
    NSArray *arr = self.navigationController.viewControllers;
    for (UIViewController *vc in arr) {
        if ([vc isKindOfClass:NSClassFromString(@"ViewController")]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
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
