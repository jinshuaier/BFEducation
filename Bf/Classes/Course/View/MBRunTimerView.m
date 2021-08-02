//
//  MBRunTimerView.m
//  MobileTeaching
//
//  Created by Apple on 2017/9/12.
//  Copyright © 2017年 mainbo. All rights reserved.
//

#import "MBRunTimerView.h"
#import "UIColor+Extension.h"

//Degress to PI
#define CATDegreesToRadians(x) (M_PI*(x)/180.0)

//Defalut value
#define CATProgressLineWidth      (15)
#define CATProgressStartAngle     (-90)
#define CATProgressEndAngle       (270)
#define CATProgressCurveBgColor   [UIColor colorWithRed:3/255.0f green:252/255.0f blue:254/255.0f alpha:0.25]
#define CATGradientColor          [UIColor cyanColor]
#define CATGradient1Color         [UIColor blueColor]
#define CATGradient2Color         [UIColor redColor]

@interface MBRunTimerView ()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer1;
@property (nonatomic, strong) CAGradientLayer *gradientLayer2;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, assign) CGFloat lastProgress;
@property (nonatomic, assign) CGFloat lastCountDown;

@property(nonatomic,strong)NSTimer *timer; // timer

@property(nonatomic,strong)NSDate *beforeDate; // 上次进入后台时间

/**
 @abstract label
 */
@property (nonatomic, strong) UILabel *label;
@end

@implementation MBRunTimerView


#pragma mark --
#pragma mark -- Init &  dealloc

-(void)dealloc{
    self.curveBgColor = nil;
    self.progressColor = nil;
    self.trackLayer = nil;
    self.progressLayer = nil;
    self.gradientLayer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _commonInit];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _label.textAlignment = NSTextAlignmentCenter;
        //字体
        UIFont *font = [UIFont systemFontOfSize:0.20 * self.width];
//        UIFont *font = [UIFont systemFontOfSize:PXTOPT(102)];
        _label.font = font;
        _label.textColor = [UIColor colorWithHexString:@"fefefe"];
        [self initTimerState];
        [self addSubview:_label];
    }
    return self;
}

- (void)initTimerState{
    [self setProgress:0];
    _label.text = @"0 %";
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}

-(void)_commonInit{
    //1.Track layer
    _curveBgColor = CATProgressCurveBgColor;
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.frame=self.bounds;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    _trackLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_trackLayer];
    
    //2.Progress layer
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.frame=self.bounds;
    _progressLayer.fillColor=[[UIColor clearColor] CGColor];
    _progressLayer.strokeColor=[UIColor blueColor].CGColor;//!!!不能用clearColor
    _progressLayer.lineCap=kCALineCapRound;
    _progressLayer.strokeEnd=0.0;
    
    _gradient1 = CATGradient1Color;
    _gradient2 = CATGradient2Color;
    _startAngle = CATProgressStartAngle;
    _endAngle = CATProgressEndAngle;
    _progressLineWidth = CATProgressLineWidth;
    
    //3.Enable gradient
    [self setEnableGradient:YES];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _trackLayer.frame=self.bounds;
    _progressLayer.frame=self.bounds;
    
    [self setProgressLineWidth:_progressLineWidth];
}

#pragma mark --
#pragma mark -- Public Methods

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    progress = progress < 0.0f ? 0.0f : progress;
    progress = progress > 1.0f ? 1.0f : progress;
    _lastProgress = _progress;
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
//    if(_delegate && [_delegate respondsToSelector:@selector(progressView:progressChanged:lastProgress:countDown:)]){
//        [_delegate progressView:self progressChanged:_progress lastProgress:_lastProgress  countDown:_countDown];
//    }
}

#pragma mark --
#pragma mark -- Setters && Getters

-(void)setCurveBgColor:(UIColor *)curveBgColor{
    _curveBgColor = curveBgColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
}

//Enable gradient effect

-(void)setGradient1:(UIColor *)gradientColor1{
    _gradient1 = gradientColor1;
    if(_enableGradient == true) {
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        [self.layer addSublayer:self.gradientLayer];
    }
}

-(void)setGradient2:(UIColor *)gradientColor2{
    _gradient2 = gradientColor2;
    if(_enableGradient == true) {
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        [self.layer addSublayer:self.gradientLayer];
    }
}

-(void)setEnableGradient:(CGFloat)enableGradient{
    _enableGradient = enableGradient;
    if (_enableGradient) {
        if (_progressLayer) {
            [_progressLayer removeFromSuperlayer];
        }
        if (![self.layer.sublayers containsObject:self.gradientLayer]) {
            [self.layer addSublayer:self.gradientLayer];
        }
    }else{
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        if (![self.layer.sublayers containsObject:_progressLayer]) {
            [self.layer addSublayer:_progressLayer];
        }
    }
}

-(NSArray *)arrayFromColorArray:(NSArray *)colorArray{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:colorArray.count];
    for (UIColor* color in colorArray) {
        [array addObject:(id)color.CGColor];
    }
    return array;
}


-(void)setProgressColor:(UIColor *)progressColor{
    if (!progressColor) return;
    _progressColor = progressColor;
    _progressLayer.strokeColor= _progressColor.CGColor;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth{
    if (progressLineWidth < 0.5f) return;
    _progressLineWidth = progressLineWidth;
    
    _trackLayer.lineWidth = _progressLineWidth;
    CGFloat radius = self.frame.size.width/2-_progressLineWidth;
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:radius startAngle:CATDegreesToRadians(_startAngle) endAngle:CATDegreesToRadians(_endAngle) clockwise:YES];
    _trackLayer.path=path.CGPath;
    
    _progressLayer.path = path.CGPath;
    _progressLayer.lineWidth=_progressLineWidth;
}

-(void)setStartAngle:(int)startAngle{
    _startAngle = startAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setEndAngle:(int)endAngle{
    _endAngle = endAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setProgress:(CGFloat)progress{
    [self setProgress:progress animated:YES];
}

- (CALayer *)gradientLayer {
    if(_gradientLayer == nil) {
        _gradientLayer=[CALayer layer];
        
        _gradientLayer1=[CAGradientLayer layer];
        _gradientLayer1.frame=CGRectMake(0, 0, self.bounds.size.width,  self.bounds.size.height);
        [_gradientLayer1 setColors:[NSArray arrayWithObjects:(id)_gradient1.CGColor,(id)_gradient2.CGColor, nil]];
        [_gradientLayer1 setStartPoint:CGPointMake(0.5, 0.2)];//[0 - 1]
        [_gradientLayer1 setEndPoint:CGPointMake(0.5, 0.5)];
        [_gradientLayer addSublayer:_gradientLayer1];
        
        [_gradientLayer setMask:_progressLayer];
    }
    return _gradientLayer;
}

// 设置运行时间和进度
- (void)setCountDownWithTotalTime:(NSInteger)totalTime countDown:(NSInteger)countDown animated:(BOOL)animated{
    dispatch_async(dispatch_get_main_queue(), ^{
//        _label.text = [self formatTimeWithSecond:countDown / 1000];
        CGFloat pro = (CGFloat)(countDown) / (CGFloat)totalTime;
//        NSLog(@"+++++%lf",pro);
        [self setProgress:pro animated:animated];
        _label.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(pro * 100)];
    });
}

- (NSString *)formatTimeWithSecond:(NSInteger)seconds{
    return [NSString stringWithFormat:@"%02ld:%02ld",seconds / 60,seconds % 60];
}

@end

