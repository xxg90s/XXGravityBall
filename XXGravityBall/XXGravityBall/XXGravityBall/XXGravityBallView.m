//
//  XXGravityBallView.m
//  XXGravityBall
//
//  Creatyd by xxg90s on 2018/1/17.
//  Copyright © 2018年 xxg90s Inc. All rights reserved.
//

#import "XXGravityBallView.h"

#define GBBALLWIDTH 40.

@implementation XXGravityBallView

- (void)setGravityBall:(XXGravityBallItem *)gravityBall {
    _gravityBall = gravityBall;
    
    self.image = [UIImage imageNamed:_gravityBall.ballName];
    self.tag = _gravityBall.ballTag;
}

- (UIDynamicItemCollisionBoundsType)collisionBoundsType {
    return UIDynamicItemCollisionBoundsTypeEllipse;
}

+ (XXGravityBallView *)factorygravityBallViewWithGravityBall:(XXGravityBallItem *)gravityBall referenceViewSize:(CGSize)referenceViewSize {
    
    XXGravityBallView *gravityBallView = [[XXGravityBallView alloc] initWithFrame:CGRectMake([[self class] randValueBetween:0 and: (referenceViewSize.width - GBBALLWIDTH)], [[self class] randValueBetween:0 and:(referenceViewSize.height - GBBALLWIDTH)], GBBALLWIDTH, GBBALLWIDTH)];
    gravityBallView.layer.cornerRadius = gravityBallView.frame.size.width/2;
    gravityBallView.layer.borderWidth = 1.;
    gravityBallView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    gravityBallView.layer.masksToBounds = YES;
    gravityBallView.gravityBall = gravityBall;
    
    return gravityBallView;
}

//取随机float值
+ (float)randValueBetween:(float)low and:(float)high {
    float diff = high - low;
    return (((float) rand() / RAND_MAX) * diff) + low;
}

@end
