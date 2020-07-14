//
//  LshInterActive.m
//  OCNavigation
//
//  Created by 刘松洪 on 2020/7/14.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "LshInterActive.h"

@interface LshInterActive ()
@property (nonatomic, weak) UIViewController *vc;
@end

@implementation LshInterActive

- (void)setVC:(UIViewController *)vc {
    UIPanGestureRecognizer *reg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [vc.view addGestureRecognizer:reg];
    _vc = vc;
}

- (void)handlePan:(UIPanGestureRecognizer *)reg {
    if ([reg translationInView:self.vc.view].x > 0) {
        CGFloat x = [reg translationInView:self.vc.view].x;
        CGFloat per = x / self.vc.view.bounds.size.width;
        per = MIN(1.0, MAX(0.0, per));
        
        if (reg.state == UIGestureRecognizerStateBegan) {
            self.isSwipe = YES;
            [self.vc.navigationController popViewControllerAnimated:YES];
        } else if (reg.state == UIGestureRecognizerStateChanged) {
            if (x == 0) {
                [self updateInteractiveTransition:0.01];
            } else {
                [self updateInteractiveTransition:per];
            }
        } else if (reg.state == UIGestureRecognizerStateEnded || reg.state == UIGestureRecognizerStateCancelled) {
            if (x == 0) {
                [self cancelInteractiveTransition];
            } else if (per > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            self.isSwipe = NO;
        }
    }
}


@end
