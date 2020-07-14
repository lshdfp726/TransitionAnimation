//
//  VCAnimationManager.m
//  OCNavigation
//
//  Created by 刘松洪 on 2020/7/13.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import "VCAnimationManager.h"

@interface VCAnimationManager ()
@property (nonatomic, assign) UINavigationControllerOperation operationType;
@property (nonatomic, assign) NSTimeInterval duration;
@end

@implementation VCAnimationManager

+ (instancetype)shareInstance {
    static VCAnimationManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[VCAnimationManager alloc] init];
    });
    return _manager;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _duration = 0.5;
    }
    return self;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    VCAnimationManager *manager = (VCAnimationManager *)animationController;
    return manager.interactiveTransition;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (self.interactiveTransition.isSwipe) {
        VCAnimationManager *manager = [VCAnimationManager shareInstance];
        manager.operationType = operation;
        return manager;
    } else {
        return nil;
    }
}


#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.operationType == UINavigationControllerOperationPush) { //push 动画
        UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

        
        UIView *containView = [transitionContext containerView];
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];
        
        CGFloat duration = [self transitionDuration:transitionContext];
      
        [UIView animateWithDuration:duration animations:^{
            CGAffineTransform scale =  CGAffineTransformMakeScale(0.2, 0.2);
            fromVC.view.transform = scale;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
            CGAffineTransform scale =  CGAffineTransformMakeScale(1.0, 1.0);
            fromVC.view.transform = scale;
        }];
    } else { //pop动画
        UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

        UIView *containView = [transitionContext containerView];
        [containView addSubview:toVC.view];
        [containView addSubview:fromVC.view];

        CGFloat duration = [self transitionDuration:transitionContext];

        [UIView animateWithDuration:duration animations:^{
            fromVC.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromVC.view.bounds), 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
    }
}

@end
