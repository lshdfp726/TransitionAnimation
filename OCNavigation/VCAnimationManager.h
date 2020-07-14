//
//  VCAnimationManager.h
//  OCNavigation
//
//  Created by 刘松洪 on 2020/7/13.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LshInterActive.h"
NS_ASSUME_NONNULL_BEGIN

/**
 * 专场动画处理manager，从VC剥离专场动画到此类
 */
@interface VCAnimationManager : NSObject <UINavigationControllerDelegate,UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>
+ (instancetype)shareInstance;
@property (nonatomic, weak) LshInterActive *interactiveTransition;
@end

NS_ASSUME_NONNULL_END
