//
//  XXGravityBallDisplayView.m
//  XXGravityBall
//
//  Created by xxg90s on 2018/1/17.
//  Copyright © 2018年 xxg90s Inc. All rights reserved.
//

#import "XXGravityBallDisplayView.h"
#import <CoreMotion/CoreMotion.h>

@interface XXGravityBallDisplayView () <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBeahvior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *dynamicItemBehavior;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) BOOL state;

@end

@implementation XXGravityBallDisplayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        [self createAnimator];
        [self createMotionManager];
    }
    return self;
}

- (void)createAnimator {
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    _gravityBeahvior = [[UIGravityBehavior alloc] init];
    [_animator addBehavior:_gravityBeahvior];
    
    _collisionBehavior = [[UICollisionBehavior alloc] init];
    _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [_animator addBehavior:_collisionBehavior];
    
    _dynamicItemBehavior = [[UIDynamicItemBehavior alloc] init];
    _dynamicItemBehavior.allowsRotation = YES;//允许旋转
    _dynamicItemBehavior.elasticity = .8;//弹性
    //    _dynamicItemBehavior.resistance = 0;//阻力5
    //    _dynamicItemBehavior.angularResistance = .5;//角阻力
    _dynamicItemBehavior.friction = 3;//摩擦力
    //    _dynamicItemBehavior.density = .5;//密度5
    [_animator addBehavior:_dynamicItemBehavior];
}

- (void)createMotionManager {
    _motionManager = [[CMMotionManager alloc] init];
    if (_motionManager.deviceMotionAvailable) {
        __weak typeof(self) weakSelf = self;
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [_motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            if (!error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakSelf.gravityBeahvior.gravityDirection = CGVectorMake(motion.gravity.x, -motion.gravity.y);
                });
            }
        }];
    } else {
        NSLog(@"deviceMotion不可用");
    }
}

- (void)didTapBall:(UITapGestureRecognizer *)tapGes {
    XXGravityBallView *gravityBallView = (XXGravityBallView *)tapGes.view;
    if (self.didClickBallBlock) {
        self.didClickBallBlock(gravityBallView.gravityBall);
    }
}

#pragma mark - Setter
- (void)setGravityBallViews:(NSArray<XXGravityBallView *> *)gravityBallViews {
    //移除旧数据
    for (XXGravityBallView *gravityBallView in _gravityBallViews) {
        [gravityBallView removeFromSuperview];
    }
    _gravityBallViews = gravityBallViews;
    
    for (XXGravityBallView *gravityBallView in _gravityBallViews) {
        //如果添加了操作事件，添加对应手势
        if (_enableClick) {
            gravityBallView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapBall:)];
            [gravityBallView addGestureRecognizer:tapGes];
        }
        [self addSubview:gravityBallView];
        
        [_gravityBeahvior addItem:gravityBallView];
        [_collisionBehavior addItem:gravityBallView];
        [_dynamicItemBehavior addItem:gravityBallView];
    }
}

- (void)setEnableClick:(BOOL)enableClick {
    _enableClick = enableClick;
    self.userInteractionEnabled = _enableClick;
}

#pragma mark - Public Method
- (void)setBgImage:(UIImage *)bgImage {
    self.image = bgImage;
}

- (void)setDynamicItemElasticity:(CGFloat)value; {
    _dynamicItemBehavior.elasticity = value;//弹性
}

- (void)setDynamicItemResistance:(CGFloat)value {
    _dynamicItemBehavior.resistance = value;//阻力
}

- (void)setDynamicItemFriction:(CGFloat)value {
    _dynamicItemBehavior.friction = value;//摩擦力
}
@end
