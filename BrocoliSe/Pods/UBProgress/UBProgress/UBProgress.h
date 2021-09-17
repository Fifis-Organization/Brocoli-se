//
//  UBProgress.h
//  UBProgress
//
//  Created by Paulo Uchôa on 20/07/21.
//


#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// The progress bar type.

typedef NS_ENUM (NSUInteger, UBProgressBarType) {

    // The progress bar is a circle.

    UBProgressBarTypeCircle = 0,

//     The progress bar is a line.

    UBProgressBarTypeInLine = 1
};

// The display mode of the indicator text.
typedef NS_ENUM (NSUInteger, UBProgressBarIndicatorTextDisplayMode) {

    // The indicator text is not displayed.
    UBProgressBarIndicatorTextDisplayModeNone = 0,

    // The indicator text is displayed over the background bar fixed in center.
    UBProgressBarIndicatorTextDisplayModeFixedCenter = 1,

    // The indicator text is diplayed over the progress bar.
    UBProgressBarIndicatorTextDisplayModeProgressRight = 2,
    
    // The indicator text is displayed over the background bar and over the progress bar in the center.
    UBProgressBarIndicatorTextDisplayModeProgressCenter = 3,

    // The indicator text is displayed over the background bar and over the progress bar in the right.
    UBProgressBarIndicatorTextDisplayModeFixedRight = 4
};


IB_DESIGNABLE @interface UBProgress : UIView


#pragma mark Methods

/**
 * @abstract Set the progress value.
 * @discussion Set the current progress value, which is represented by a floating-point value
 * between 0.0 and 1.0.
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

/**
 * @abstract Set the text display mode that is currently being presented.
 * @discussion The default value is set to `UBProgesssBarIndicatorDisplayModeNone`. The only mode that works with the Circle Progress is the  'UBProgressBarIndicatorTextDisplayModeFixedCenter' */
- (void)setTypeText:(UBProgressBarIndicatorTextDisplayMode)type;

/**
 * @abstract Set the text font.
 * @discussion The default value is set to 'System' , if you want to change the font weight and size, you need to pass an UIFont with weight and size */
- (void)setFont:(UIFont*_Nonnull)font;

/**
 * @abstract Set the form of the progress.
 * @discussion The default value is set to 'inLine'. */
- (void)setTypeForm:(UBProgressBarType)typeProgress;

/**
 * @abstract Set the progressBar color.
 * @discussion The default value is set to 'white' , if you want to change the background color use the 'setBackgroundTintColor' */
- (void)setProgressTintColor:(UIColor *_Nonnull)progressTintColor;

/**
 * @abstract Set the background color.
 * @discussion The default value is set to 'black' , if you want to change the progressBar color use the 'setProgressTintColor' */
- (void)setBackgroundTintColor:(UIColor * _Nonnull)backgroundTintColor;

/**
 * @abstract Set the text color.
 * @discussion The default value is set to 'Black or white' depend of the background and progress colors.*/
- (void)setLabelTextColor:(UIColor*_Nonnull)textColor;

#pragma mark Managing the Progress Bar
/** @name Managing the Progress Bar */

/**
 * @abstract The current progress shown by the receiver.
 * @discussion The current progress is represented by a floating-point value
 * between 0.0 and 1.0, inclusive, where 1.0 indicates the completion of the
 * task.
 */
@property (atomic, assign) IBInspectable CGFloat progress;

#pragma mark Configuring the Progress Bar
/** @name Configuring the Progress Bar */

/**
 * @abstract This property define the rotation angle of the progress.
 * @discussion The default value is set to '0' and it is possible to choose a value between 0 and 100. This property change the local where progress will begin. */
@property (nonatomic, assign) IBInspectable CGFloat rotationAngle;

/**
 * @abstract This property define the range angle of the progress.
 * @discussion The default value is set to '100' and it is possible to choose a value between 0 and 100. */
@property (nonatomic, assign) IBInspectable CGFloat angle;

/**
 * @abstract The color shown for the portion of the progress bar that is filled.
 */
@property (nonatomic, strong, nonnull) IBInspectable UIColor *progressTintColor; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract The color shown for the portion of the progress bar that is not
 * filled.
 * @discussion The default value is set to 'black' , if you want to change the progressBar color use the 'setProgressTintColor'*/
@property (nonatomic, strong, nonnull) IBInspectable UIColor *backgroundTintColor; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract A CGFloat value that determines the inset between the track and the
 * progressBar for the rounded progress bar type.
 * @discussion The default value is 0px.
 */
@property (nonatomic, assign) IBInspectable CGFloat progressBarInset; //UI_APPEARANCE_SELECTOR;


/**
 * @abstract A CGFloat value that determines the width of the Circle progressBar
 * @discussion The default value is 5.
 */
@property (nonatomic,assign) IBInspectable CGFloat circleProgressWidth;

/**
 * @abstract The form of the progress.
 * @discussion The default value is set to 'inLine'. */
@property (nonatomic, assign) IBInspectable UBProgressBarType typeProgress;

/**
 * @abstract The corner radius of the progress bar.
 * @discussion The default value is 0.
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius; //UI_APPEARANCE_SELECTOR;

/**
 * @abstract A Boolean value that determines whether the background is hidden.
 * @discussion Setting the value of this property to YES hides the background and
 * setting it to NO shows the background. The default value is NO.
 */
@property (nonatomic, assign) IBInspectable BOOL hideBackground;

@end

//! Project version number for YLProgressBar.
FOUNDATION_EXPORT double UBProgressVersionNumber;

//! Project version string for YLProgressBar.
FOUNDATION_EXPORT const unsigned char UBProgressVersionString[];

#import <UBProgress/UBProgress.h>
