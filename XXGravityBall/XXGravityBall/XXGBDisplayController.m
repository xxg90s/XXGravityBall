//
//  XXGBDisplayController.m
//  XXGravityBall
//
//  Created by xxg90s on 2018/1/17.
//  Copyright © 2018年 xxg90s Inc. All rights reserved.
//

#import "XXGBDisplayController.h"
#import "XXGravityBallDisplayView.h"

@interface XXGBDisplayController ()
{
    NSArray *titles;
    NSMutableArray *_labels;
}

@property (nonatomic, strong) XXGravityBallDisplayView *displayView;

@end

@implementation XXGBDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    [self createDisplayView];
    
    [self initData];
}

#pragma mark - Private Method
- (void)createUI {
    //最大值参数
    titles = [NSArray arrayWithObjects:@"弹性", @"阻力", @"摩擦力", nil];
    NSArray *maxValues = [NSArray arrayWithObjects:@"1",@"10",@"10", nil];
    NSArray *values = [NSArray arrayWithObjects:@"0.8",@"0",@"3", nil];
    _labels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < maxValues.count; i ++) {
        UISlider *_slider = [[UISlider alloc] initWithFrame:CGRectMake(130, 100 + 40*i, self.view.frame.size.width-160, 40)];//弹性
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        _slider.minimumValue = 0.0;
        _slider.maximumValue = [maxValues[i] floatValue];
        _slider.continuous = NO;
        _slider.value = [values[i] floatValue];
        _slider.tag = i;
        [self.view addSubview:_slider];
        
        UILabel *_label = [[UILabel alloc] initWithFrame:CGRectMake(10, 100 + 40*i, 100, 40)];
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentLeft;
        _label.font = [UIFont systemFontOfSize:13.];
        _label.text = [NSString stringWithFormat:@"%@:%@",titles[i],values[i]];
        [self.view addSubview:_label];
        
        [_labels addObject:_label];
    }
}

- (void)createDisplayView {
    self.displayView = [[XXGravityBallDisplayView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.6, self.view.bounds.size.width, self.view.bounds.size.height*0.4)];
    //设置背景，自行选择
    [self.displayView setBgImage:[UIImage imageNamed:@"skyBg.jpg"]];
    //设置手势，自行选择
    self.displayView.enableClick = YES;
    [self.view addSubview:self.displayView];
    
    __weak typeof(self) weakSelf = self;
    self.displayView.didClickBallBlock = ^(XXGravityBallItem *item) {
        [weakSelf didClickBall:item];
    };
}

- (void)initData {
    NSArray *images = [NSArray arrayWithObjects:@"asteroid",
                       @"blackhole",
                       @"earth",
                       @"jupiter",
                       @"mars",
                       @"mercury",
                       @"moon",
                       @"neptune",
                       @"pluto",
                       @"saturn",
                       @"sun",
                       @"supernova",
                       @"thanatos",
                       @"uranus",
                       @"venus",
                       nil];
    
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < images.count; i ++) {
        XXGravityBallItem *ballModel = [[XXGravityBallItem alloc] init];
        ballModel.ballName = images[i];
        ballModel.ballTag = i;
        
        XXGravityBallView *ball = [XXGravityBallView factorygravityBallViewWithGravityBall:ballModel referenceViewSize:CGSizeMake(self.displayView.frame.size.width, self.displayView.frame.size.height)];
        [dataSource addObject:ball];
    }
    
    [self.displayView setGravityBallViews:dataSource];
}

- (void)didClickBall:(XXGravityBallItem *)item {
    NSLog(@"点击了小球,tag = %zd",item.ballTag);
}

- (void)sliderChanged:(UISlider*)sender {
    if (sender.tag == 0) {
        //弹性
        [_displayView setDynamicItemElasticity:sender.value];
        
        UILabel *label = _labels[0];
        label.text = [NSString stringWithFormat:@"%@:%f",titles[0],sender.value];
    }
    else if (sender.tag == 1) {
        //阻力
        [_displayView setDynamicItemResistance:sender.value];
        
        UILabel *label = _labels[1];
        label.text = [NSString stringWithFormat:@"%@:%f",titles[1],sender.value];
    }
    else if (sender.tag == 2) {
        //摩擦力
        [_displayView setDynamicItemFriction:sender.value];
        
        UILabel *label = _labels[2];
        label.text = [NSString stringWithFormat:@"%@:%f",titles[2],sender.value];
    }
    
}

@end
