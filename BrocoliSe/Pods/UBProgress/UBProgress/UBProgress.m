//
//  UBProgress.m
//  UBProgress
//
//  Created by Paulo Uchôa on 20/07/21.
//


#import "UBProgress.h"

// Sizes
const NSInteger UBProgressBarDefaultSizeInset = 0; //px

// Animation times
const NSTimeInterval UBProgressBarProgressTime = 0.25f; // s

// Default progress value
const CGFloat UBProgressBarDefaultProgress = 0.3f;

@interface UBProgress ()
@property (nonatomic, assign) CGFloat internalCornerRadius;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSTimer *progressTargetTimer;
@property (nonatomic, assign) CGFloat progressTargetValue;
@property (nonatomic, strong, nonnull) IBInspectable UILabel *indicatorTextLabel;
@property (nonatomic, assign) IBInspectable UBProgressBarIndicatorTextDisplayMode indicatorTextDisplayMode;
@property (nonatomic, strong, nonnull) NSArray *progressTintColors;

// Init the progress bar with the default values.
- (void)initializeProgressBar;

// Draw the background (track) of the slider.
- (void)drawBackground:(CGContextRef)context withRect:(CGRect)rect;

- (void)drawBackgroundInLine:(CGContextRef)context withRect:(CGRect)rect;

- (void)drawBackgroundInCircle:(CGContextRef)context withRect:(CGRect)rect;

// Draw the progress bar.
- (void)drawProgressBar:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect;

- (void)drawProgressBarInLine:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect;

- (void)drawProgressBarInCircle:(CGRect)rect context:(CGContextRef)context;

// Draw the given text into the given location of the rect.
- (void)drawText:(CGContextRef)context withRect:(CGRect)rect;

- (void)drawRect:(CGRect)rect;

// Callback for the setProgress:Animated: animation timer.
- (void)updateProgressWithTimer:(NSTimer *)timer;

- (void)setProgressTintColors:(NSArray *)progressTintColors;

@end

@implementation UBProgress
@synthesize progress = _progress;

- (void)dealloc {
    NSLog(@"dealloc !!!");
    
    if (_progressTargetTimer && [_progressTargetTimer isValid]) {
        [_progressTargetTimer invalidate];
    }
}

- (id)initWithFrame:(CGRect)frameRect {
    if ((self = [super initWithFrame:frameRect])) {
        [self initializeProgressBar];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initializeProgressBar];
    }
    return self;
}

- (void)removeFromSuperview {
    [super removeFromSuperview];
    
    if (_progressTargetTimer && [_progressTargetTimer isValid]) {
        [_progressTargetTimer invalidate];
    }
}

#pragma mark - Properties

- (CGFloat)progress {
    @synchronized (self) {
        return _progress;
    }
}

#pragma mark - Public Methods

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    @synchronized (self) {
        if (_progressTargetTimer && [_progressTargetTimer isValid]) {
            [_progressTargetTimer invalidate];
        }
        
        CGFloat newProgress = progress;
        if (newProgress > 1.0f) {
            newProgress = 1.0f;
        } else if (newProgress < 0.0f) {
            newProgress = 0.0f;
        }
        
        if (animated) {
            _progressTargetValue = newProgress;
            CGFloat incrementValue = ((_progressTargetValue - _progress) * (1.0f / 30.0f))/ UBProgressBarProgressTime;
            
            if (incrementValue == 0) {
                return;
            }
            
            self.progressTargetTimer = [NSTimer timerWithTimeInterval:1.0f / 30.0f
                                                               target:self
                                                             selector:@selector(updateProgressWithTimer:)
                                                             userInfo:[NSNumber numberWithFloat:incrementValue]
                                                              repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_progressTargetTimer forMode:NSRunLoopCommonModes];
        } else {
            _progress = newProgress;
            
            [self setNeedsDisplay];
        }
    }
}

- (void)setTypeForm:(UBProgressBarType)typeProgress {
    
    switch (typeProgress) {
        case UBProgressBarTypeCircle:
            _typeProgress = UBProgressBarTypeCircle;
            break;
        case UBProgressBarTypeInLine:
            _typeProgress = UBProgressBarTypeInLine;
            break;
        default:
            _typeProgress = UBProgressBarTypeInLine;
            break;
  }
}

-(void)setFont:(UIFont*_Nonnull)font {
    _indicatorTextLabel.font = font;
}

- (void)setTypeText:(UBProgressBarIndicatorTextDisplayMode)typeText {

    if (_typeProgress == UBProgressBarTypeInLine) {
        switch (typeText) {
            case 1:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeFixedCenter;
                break;
            case 2:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeProgressRight;
                break;
            case 3:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeProgressCenter;
                break;
            case 4:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeFixedRight;
                break;
            default:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeNone;
                break;
        }
    } else {
        switch (typeText) {
            case 0:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeFixedCenter;
                break;
                
            default:
                _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeNone;
                break;
        }
    }
}

-(void)setLabelTextColor:(UIColor*)textColor {
    _indicatorTextLabel.textColor = textColor;
}


- (void)setProgressTintColor:(UIColor *)progressTintColor {
    progressTintColor  = (progressTintColor) ? progressTintColor : [UIColor blueColor];
    _progressTintColor = progressTintColor;
    
    [self setProgressTintColors:@[_progressTintColor, _progressTintColor]];
}

- (void)setBackgroundTintColor:(UIColor *)backgroundTintColor {
    backgroundTintColor  = (backgroundTintColor) ? backgroundTintColor : [UIColor blueColor];
    _backgroundTintColor = backgroundTintColor;
}

#pragma mark - Private Methods

- (void)updateProgressWithTimer:(NSTimer *)timer {
    CGFloat dt_progress = [timer.userInfo floatValue];
    
    _progress += dt_progress;
    
    if ((dt_progress < 0 && _progress <= _progressTargetValue)
        || (dt_progress > 0 && _progress >= _progressTargetValue)) {

        [_progressTargetTimer invalidate];
        _progressTargetTimer = nil;
        _progress = _progressTargetValue;
    }
    [self setNeedsDisplay];
}

- (void)drawBackground:(CGContextRef)context withRect:(CGRect)rect {
    
    if (_typeProgress == UBProgressBarTypeCircle) {
        [self drawBackgroundInCircle:context withRect:rect];
        
    } else {
        [self drawBackgroundInLine:context withRect:rect];
    }
    
}

- (void)drawBackgroundInLine:(CGContextRef)context withRect:(CGRect)rect  {
    // Define the progress bar pattern to clip all the content inside
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))
    cornerRadius:_internalCornerRadius];
    [roundedRect addClip];
    
    CGContextSaveGState(context); {
        CGFloat trackWidth  = CGRectGetWidth(rect);
        CGFloat trackHeight = CGRectGetHeight(rect);
        
        // Draw the track
        UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, trackWidth, trackHeight) cornerRadius:_internalCornerRadius];
        [_backgroundTintColor set];
        [roundedRect fill];
    }
    CGContextRestoreGState(context);
    
}

- (void)drawBackgroundInCircle:(CGContextRef)context withRect:(CGRect)rect  {
    
    CGPoint center = {CGRectGetMidX(rect), CGRectGetMidY(rect)};
    CGFloat radius = (MIN(CGRectGetWidth(rect), CGRectGetHeight(rect))/2)- self.circleProgressWidth;
    
    radius = radius - self.circleProgressWidth/2.f;
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect))
    cornerRadius:_internalCornerRadius];
    [roundedRect addClip];
    
    CGMutablePathRef arc = CGPathCreateMutable();
       CGPathAddArc(arc, NULL,
                    center.x, center.y, radius,
                    (self.angle/100.f)*M_PI-((-self.rotationAngle/100.f)*2.f+0.5)*M_PI-(2.f*M_PI)*(self.angle/100.f)*(100.f-100.f*self.progress/1.f)/100.f,
                    -(self.angle/100.f)*M_PI-((-self.rotationAngle/100.f)*2.f+0.5)*M_PI,
                    YES);
    
    CGPathRef strokedArc =
      CGPathCreateCopyByStrokingPath(arc, NULL,
                                     self.circleProgressWidth,
                                     (CGLineCap)kCGLineCapRound,
                                     kCGLineJoinMiter,
                                     10);
      
      
      CGContextAddPath(context, strokedArc);
      CGContextSetStrokeColorWithColor(context, self.backgroundTintColor.CGColor);
      CGContextSetFillColorWithColor(context, self.backgroundTintColor.CGColor);
      CGContextDrawPath(context, kCGPathFillStroke);
      
      CGPathRelease(arc);
      CGPathRelease(strokedArc);
    
}

- (void)drawProgressBar:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect {
    if (_typeProgress == UBProgressBarTypeCircle) {
        [self drawProgressBarInCircle:outterRect context:context];
    } else {
        [self drawProgressBarInLine:context withInnerRect:innerRect outterRect:outterRect];
    }
}

- (void)drawProgressBarInCircle:(CGRect)rect context:(CGContextRef)context {
    
    CGPoint center = {CGRectGetMidX(rect), CGRectGetMidY(rect)};
    CGFloat radius = (MIN(CGRectGetWidth(rect), CGRectGetHeight(rect))/2) - self.circleProgressWidth;
    
    radius = radius - self.circleProgressWidth/2.f;
    
    CGMutablePathRef arc = CGPathCreateMutable();
    CGPathAddArc(arc, NULL,
                 center.x, center.y, radius,
                 (self.angle/100.f)*M_PI-((-self.rotationAngle/100.f)*2.f+0.5)*M_PI-(2.f*M_PI)*(self.angle/100.f)*(100.f-100.f*self.progress/1.f)/100.f,
                 -(self.angle/100.f)*M_PI-((-self.rotationAngle/100.f)*2.f+0.5)*M_PI,
                 YES);
    
    CGPathRef strokedArc =
    CGPathCreateCopyByStrokingPath(arc, NULL,
                                   self.circleProgressWidth,
                                   (CGLineCap)kCGLineCapRound,
                                   kCGLineJoinMiter,
                                   10);

    
    CGContextAddPath(context, strokedArc);
    CGContextSetFillColorWithColor(context, self.progressTintColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.progressTintColor.CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGPathRelease(arc);
    CGPathRelease(strokedArc);
}

- (void)drawProgressBarInLine:(CGContextRef)context withInnerRect:(CGRect)innerRect outterRect:(CGRect)outterRect {
    CGRect gradientRect = innerRect;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextSaveGState(context); {
        UIBezierPath *progressBounds = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:_internalCornerRadius];
        CGContextAddPath(context, [progressBounds CGPath]);
        CGContextClip(context);
        
        CFArrayRef colorRefs  = (__bridge CFArrayRef)_colors;
        NSUInteger colorCount = [_colors count];
        
        CGFloat delta      = 1.0f / [_colors count];
        CGFloat semi_delta = delta / 2.0f;
        CGFloat locations[colorCount];
        
        for (NSInteger i = 0; i < colorCount; i++) {
            locations[i] = delta * i + semi_delta;
        }
        
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colorRefs, locations);
        
        CGContextDrawLinearGradient(context, gradient, CGPointMake(CGRectGetMinX(gradientRect), CGRectGetMinY(gradientRect)), CGPointMake(CGRectGetMinX(gradientRect) + CGRectGetWidth(gradientRect), CGRectGetMinY(gradientRect)), (kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation));
        
        CGGradientRelease(gradient);
    }
    CGContextRestoreGState(context);
    
    CGColorSpaceRelease(colorSpace);
}

- (void)drawText:(CGContextRef)context withRect:(CGRect)rect {
    if (_indicatorTextLabel == nil) {
        return;
    }
    
    CGRect innerRect          = CGRectInset(rect, 4, 2);
    _indicatorTextLabel.frame = innerRect;
    
    NSString *indicatorText = _indicatorTextLabel.text;
    BOOL hasText            = (_indicatorTextLabel.text != nil);
    
    if (!hasText) {
        indicatorText = [NSString stringWithFormat:@"%.0f%%", (self.progress * 100)];
    }
    
    CGRect textRect = CGRectZero;
    if ([indicatorText respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        textRect = [indicatorText boundingRectWithSize:CGRectInset(innerRect, 20, 0).size
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName: _indicatorTextLabel.font }
                                               context:nil];
    }
    
    if (innerRect.size.width < textRect.size.width || innerRect.size.height + 4 < textRect.size.height) {
        return;
    }
    
    _indicatorTextLabel.text = indicatorText;
    
    BOOL hasTextColor = ![_indicatorTextLabel.textColor isEqual:[UIColor clearColor]];
    
    if (!hasTextColor) {
        CGColorRef backgroundColor = nil;

        if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixedCenter) {
            backgroundColor = _backgroundTintColor.CGColor ?: [UIColor blackColor].CGColor;
        } else {
            backgroundColor = (__bridge CGColorRef)[_colors lastObject];
        }

        const CGFloat *components = CGColorGetComponents(backgroundColor);
        BOOL isLightBackground    = (components[0] + components[1] + components[2]) / 3.0f >= 0.5f;

        _indicatorTextLabel.textColor = (isLightBackground) ? [UIColor blackColor] : [UIColor whiteColor];
    }
    
    [_indicatorTextLabel drawTextInRect:innerRect];
    
    if (!hasTextColor) {
        _indicatorTextLabel.textColor = [UIColor clearColor];
    }
    if (!hasText) {
        _indicatorTextLabel.text = nil;
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.isHidden) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Refresh the corner radius value
    self.internalCornerRadius = 0;

    if (_cornerRadius > 0) {
        self.internalCornerRadius = _cornerRadius;
    }
    // Draw the background track
    if (!_hideBackground) {
        [self drawBackground:context withRect:rect];
    }
    
    // Compute the inner rectangle
    CGRect innerRect;
    
    innerRect = CGRectMake(_progressBarInset,
                           _progressBarInset,
                           CGRectGetWidth(rect) * self.progress - 2 * _progressBarInset,
                           CGRectGetHeight(rect) - 2 * _progressBarInset);
    
    CGRect centerRect;
    
    centerRect = CGRectMake(0,
                            0,
                            CGRectGetWidth(rect),
                            CGRectGetHeight(rect));

    [self drawProgressBar:context withInnerRect:innerRect outterRect:rect];
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixedCenter) {
        [self drawText:context withRect:centerRect];
    }
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeProgressRight) {
        [self drawText:context withRect:innerRect];
        _indicatorTextLabel.textAlignment = NSTextAlignmentRight;
    }

    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeProgressCenter) {
        [self drawText:context withRect:innerRect];
    }
    
    // Draw the indicator text if necessary
    if (_indicatorTextDisplayMode == UBProgressBarIndicatorTextDisplayModeFixedRight) {
        [self drawText:context withRect:rect];
        _indicatorTextLabel.textAlignment = NSTextAlignmentRight;
    }
}

- (void)setProgressTintColors:(NSArray *)progressTintColors {
    NSAssert(progressTintColors, @"progressTintColors must not be null");
    NSAssert([progressTintColors count], @"progressTintColors must contain at least one element");

    if (_progressTintColors != progressTintColors) {
        _progressTintColors = progressTintColors;
    }

    NSMutableArray *colors  = [NSMutableArray arrayWithCapacity:[progressTintColors count]];
    for (UIColor *color in progressTintColors) {
        [colors addObject:(id)color.CGColor];
    }
    self.colors = colors;
}

- (void)initializeProgressBar {
    //    _type
    _progress        = UBProgressBarDefaultProgress;
    _hideBackground       = NO;
    _cornerRadius    = 0;
    
    _indicatorTextLabel                           = [[UILabel alloc] initWithFrame:self.frame];
    _indicatorTextLabel.adjustsFontSizeToFitWidth = YES;
    _indicatorTextLabel.backgroundColor           = [UIColor clearColor];
    _indicatorTextLabel.lineBreakMode             = NSLineBreakByTruncatingHead;
    _indicatorTextLabel.font = [UIFont fontWithName: @"System" size: 20];
    _indicatorTextLabel.textAlignment             = NSTextAlignmentCenter;
    _indicatorTextLabel.textColor                 = [UIColor clearColor];
    _indicatorTextLabel.minimumScaleFactor        = 3;
    
    _indicatorTextDisplayMode = UBProgressBarIndicatorTextDisplayModeNone;
    _typeProgress = UBProgressBarTypeInLine;
    _circleProgressWidth = 5;
    
    _angle = 100.f;
    _rotationAngle = 0.f;
    
    self.backgroundTintColor      = [UIColor blackColor];
    self.progressTintColor        = self.backgroundColor;
    self.progressBarInset         = UBProgressBarDefaultSizeInset;
    self.backgroundColor          = [UIColor clearColor];
}

@end
