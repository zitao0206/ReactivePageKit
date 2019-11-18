//
//  UIView+EasyLayout.h
//  EasyLayout
//
//  Created by lizitao on 2018/6/21.
//

#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>

@interface UIView (EasyLayout)
/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;
/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;
/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;
/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;
/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat viewWidth;
/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat viewHeight;
/**
 * Shortcut for frame.size.witdth*0.5
 */
@property (nonatomic,readonly) CGFloat inCenterX;
/**
 * Shortcut for frame.size.height*0.5
 */
@property (nonatomic,readonly) CGFloat inCenterY;

/**
 * Shortcut for CGPointMake(self.inCenterX,self.inCenterY)
 */
@property (nonatomic,readonly) CGPoint inCenter;
/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;
/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;
/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;
/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;
/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;
/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;
/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;
/**
 *等比例按照宽度重新设定size
 */
-(CGSize)resizeWithWidth:(CGFloat)width;

/**
 *等比例按照高度重新设定size
 */
-(CGSize)resizeWithHeight:(CGFloat)height;
/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;
/**
 * set Rotation
 */
-(void)setRotation:(CGFloat)rotation;
/**
 * set frame Left Inside Frame
 */
-(void)setFrameLeftInsideFrame:(CGRect)superFrame centered:(BOOL)centered;
/**
 * set frame Right Inside Frame
 */
-(void)setFrameRightInsideFrame:(CGRect)superFrame centered:(BOOL)centered;
/**
 * set frame Bottom Inside Frame
 */
-(void)setFrameBottomedInsideFrame:(CGRect)superFrame centered:(BOOL)centered;
/**
 * set frame Top Inside Frame
 */
-(void)setFrameToppedInsideFrame:(CGRect)superFrame centered:(BOOL)centered;
/**
 * set centerY Inside Frame
 */
-(void)centerYInsideFrame:(CGRect)superFrame;
/**
 * set centerX Inside Frame
 */
-(void)centerXInsideFrame:(CGRect)superFrame;
/**
 * set center Inside Frame
 */
-(void)centerInsideFrame:(CGRect)superFrame;
/**
 * shift Y
 */
-(void)shiftFrameY:(CGFloat)shift;
/**
 * shift X
 */
-(void)shiftFrameX:(CGFloat)shift;
/**
 * shift Width
 */
-(void)shiftFrameWidth:(CGFloat)shift;
/**
 * shift Height
 */
-(void)shiftFrameHeight:(CGFloat)shift;
/**
 * set height and width shift Frame
 */
-(void)setSQFrame:(CGFloat)shift;
/**
 * set to zero pos location
 */
-(void)setZeroPos;
/**
 * set to zero size
 */
-(void)setZeroSize;
@end
