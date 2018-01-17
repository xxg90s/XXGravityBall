//
//  XXGravityBallView.h
//  XXGravityBall
//
//  Created by xxg90s on 2018/1/17.
//  Copyright © 2018年 xxg90s Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXGravityBallItem.h"

@interface XXGravityBallView : UIImageView

@property (nonatomic, strong) XXGravityBallItem *gravityBall;

/**
 类方法创建重力球视图
 
 @param gravityBall 重力球model
 @param referenceViewSize  重力作用视图的大小，在此范围内随机生成ball的frame
 @return 重力球视图
 */
+ (XXGravityBallView *)factorygravityBallViewWithGravityBall:(XXGravityBallItem *)gravityBall referenceViewSize:(CGSize)referenceViewSize;

@end
