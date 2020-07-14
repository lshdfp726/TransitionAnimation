//
//  LshInterActive.h
//  OCNavigation
//
//  Created by 刘松洪 on 2020/7/14.
//  Copyright © 2020 刘松洪. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 重写系统的交互处理类，为了把交互代码从VC里面剥离到这里
 */
@interface LshInterActive : UIPercentDrivenInteractiveTransition
- (void)setVC:(UIViewController *)vc;
@property (nonatomic, assign) BOOL isSwipe;//是否是滑动返回
@end

NS_ASSUME_NONNULL_END
