//
//  XYWaterWaveView.m
//  XYWaterWaveView
//
//  Created by wing on 2017/12/1.
//  Copyright © 2017年 wing. All rights reserved.
//
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#import "XYWaterWaveView.h"

@interface XYWaterWaveView ()


@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic,strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer *secondeWaveLayer;
@property (nonatomic,strong) CAShapeLayer *thirdWaveLayer;

@end

@implementation XYWaterWaveView
{
    CGFloat _waveAmplitude1;      //!< 振幅
    CGFloat _waveAmplitude2;
    CGFloat _waveAmplitude3;
    
    CGFloat _waveCycle;          //!< 周期
    
    CGFloat _waveSpeed1;          //!< 速度
    CGFloat _waveSpeed2;
    CGFloat _waveSpeed3;
    
    CGFloat _waterWaveHeight;
    CGFloat _waterWaveWidth;
    
    CGFloat _wavePointY1;
    CGFloat _wavePointY2;
    CGFloat _wavePointY3;
    
    CGFloat _waveOffsetX1; //!< 波浪x位移
    CGFloat _waveOffsetX2;
    CGFloat _waveOffsetX3;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgba(255, 91, 91,0);
        self.layer.masksToBounds = NO;
        
        [self ConfigParams];
        
        [self startWave];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    self.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, rect.size.height - 20)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width, 0)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 20)];
    [path addQuadCurveToPoint:CGPointMake(0, rect.size.height - 20) controlPoint:CGPointMake(rect.size.width * 0.5, rect.size.height + 50)];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.strokeColor = [UIColor clearColor].CGColor;
    shape.fillColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    [self.layer addSublayer:shape];
}
#pragma mark 配置参数
- (void)ConfigParams
{
    _waterWaveWidth = self.frame.size.width;
    _waterWaveHeight = 400;
    
    _waveSpeed1 = 0.02/M_PI;
    _waveSpeed2 = 0.03/M_PI;
    _waveSpeed3 = 0.04/M_PI;
    
    _waveOffsetX1 = 0;
    _waveOffsetX2 = 0;
    _waveOffsetX3 = 0;
    
    _wavePointY1 = 100;
    _wavePointY2 = 100;
    _wavePointY3 = 100;
    
    _waveAmplitude1 = 30;
    _waveAmplitude2 = 40;
    _waveAmplitude3 = 50;
    _waveCycle =  1 * M_PI / _waterWaveWidth;
}

#pragma mark 加载layer ，绑定runloop 帧刷新
- (void)startWave
{
    [self.layer addSublayer:self.firstWaveLayer];
    [self.layer addSublayer:self.secondeWaveLayer];
    [self.layer addSublayer:self.thirdWaveLayer];
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark 帧刷新事件
- (void)getCurrentWave
{
    _waveOffsetX1 += _waveSpeed1;
    _waveOffsetX2 += _waveSpeed2;
    _waveOffsetX3 += _waveSpeed3;
    [self setFirstWaveLayerPathWithOffsetX:_waveOffsetX1];
    [self setSecondWaveLayerPathWithOffsetX:_waveOffsetX2];
    [self setThirdWaveLayerPathWithOffsetX:_waveOffsetX3];
    
}

#pragma mark 三个shapeLayer动画
- (void)setFirstWaveLayerPathWithOffsetX:(CGFloat)waveOffsetX
{
    
    
    CGFloat yP = 100;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, yP)];
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        yP = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX - 10) + _wavePointY1 + 10;
        [bezierPath addLineToPoint:CGPointMake(x, yP)];
    }
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, self.bounds.size.height - 20) controlPoint:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height + 50)];
    _firstWaveLayer.path = bezierPath.CGPath;
    
    
}

- (void)setSecondWaveLayerPathWithOffsetX:(CGFloat)waveOffsetX
{
    CGFloat yP = 100;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, yP)];
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        yP = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX - 10) + _wavePointY1 + 10;
        [bezierPath addLineToPoint:CGPointMake(x, yP)];
    }
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, self.bounds.size.height - 20) controlPoint:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height + 50)];
    _secondeWaveLayer.path = bezierPath.CGPath;
}

- (void)setThirdWaveLayerPathWithOffsetX:(CGFloat)waveOffsetX
{
    CGFloat yP = 100;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, yP)];
    for (float x = 0.0f; x <= _waterWaveWidth; x ++) {
        yP = _waveAmplitude1 * sin(_waveCycle * x + waveOffsetX - 10) + _wavePointY1 + 10;
        [bezierPath addLineToPoint:CGPointMake(x, yP)];
    }
    [bezierPath addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - 20)];
    [bezierPath addQuadCurveToPoint:CGPointMake(0, self.bounds.size.height - 20) controlPoint:CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height + 50)];
    _thirdWaveLayer.path = bezierPath.CGPath;
}

#pragma mark Get
- (CAShapeLayer *)firstWaveLayer
{
    if (!_firstWaveLayer) {
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        _firstWaveLayer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondeWaveLayer
{
    if (!_secondeWaveLayer) {
        _secondeWaveLayer = [CAShapeLayer layer];
        _secondeWaveLayer.fillColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
        _secondeWaveLayer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
        
    }
    return _secondeWaveLayer;
}

- (CAShapeLayer *)thirdWaveLayer
{
    if (!_thirdWaveLayer) {
        _thirdWaveLayer = [CAShapeLayer layer];
        _thirdWaveLayer.fillColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        _thirdWaveLayer.strokeColor = [[UIColor blackColor] colorWithAlphaComponent:0.1].CGColor;
    }
    return _thirdWaveLayer;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}
@end
