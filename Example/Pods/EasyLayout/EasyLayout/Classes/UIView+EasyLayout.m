//
//  UIView+EasyLayout.m
//  EasyLayout
//
//  Created by lizitao on 2018/6/21.
//

#import "UIView+EasyLayout.h"

@implementation UIView (EasyLayout)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)viewWidth
{
    return self.frame.size.width;
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)viewHeight
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setViewHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)inCenterX
{
    return self.frame.size.width*0.5;
}

- (CGFloat)inCenterY
{
    return self.frame.size.height*0.5;
}

- (CGPoint)inCenter
{
    return CGPointMake(self.inCenterX, self.inCenterY);
}

- (CGFloat)ttScreenX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)ttScreenY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX
{
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    return x;
}

- (CGFloat)screenViewY
{
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame
{
    return CGRectMake(self.screenViewX, self.screenViewY, self.viewWidth, self.viewHeight);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)orientationWidth
{
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.viewHeight : self.viewWidth;
}

- (CGFloat)orientationHeight
{
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
    ? self.viewWidth : self.viewHeight;
}


- (CGSize)resizeWithWidth:(CGFloat)width
{
    [self sizeToFit];
    CGFloat height = width / self.frame.size.width * self.frame.size.height;
    self.frame = CGRectMake(0, 0, width, height);
    return CGSizeMake(width, height);
}

- (CGSize)resizeWithHeight:(CGFloat)height
{
    [self sizeToFit];
    CGFloat width = height / self.frame.size.height * self.frame.size.width;
    self.frame = CGRectMake(0, 0, width, height);
    return CGSizeMake(width, height);
}

- (CGPoint)offsetFromView:(UIView*)otherView
{
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}

-(void)setRotation:(CGFloat)rotation
{
    self.transform = CGAffineTransformMakeRotation(rotation);
}

-(void)setFrameLeftInsideFrame:(CGRect)superFrame centered:(BOOL)centered
{
    CGRect frame =self.frame;
    frame.origin.x = 0;
    if (centered) {
        frame.origin.y = (superFrame.size.height/2) - (frame.size.height/2);
    }
    self.frame = frame;
}

-(void)setFrameRightInsideFrame:(CGRect)superFrame centered:(BOOL)centered
{
    CGRect frame =self.frame;
    frame.origin.x = superFrame.size.width-self.frame.size.width;
    if (centered) {
        frame.origin.y = (superFrame.size.height/2) - (frame.size.height/2);
    }
    self.frame = frame;
}


-(void)setFrameBottomedInsideFrame:(CGRect)superFrame centered:(BOOL)centered
{
    
    CGRect frame =self.frame;
    frame.origin.y = superFrame.size.height-self.frame.size.height;
    if (centered) {
        frame.origin.x = (superFrame.size.width/2) - (frame.size.width/2);
    }
    self.frame = frame;
}


-(void)setFrameToppedInsideFrame:(CGRect)superFrame centered:(BOOL)centered
{
    
    CGRect frame =self.frame;
    frame.origin.y = 0;
    if (centered) {
        frame.origin.x = (superFrame.size.width/2) - (frame.size.width/2);
    }
    self.frame = frame;
    
}

-(void)centerYInsideFrame:(CGRect)superFrame
{
    CGRect frame =self.frame;
    frame.origin.y = (superFrame.size.height/2) - (frame.size.height/2);
    self.frame = frame;
}


-(void)centerXInsideFrame:(CGRect)superFrame
{
    CGRect frame =self.frame;
    frame.origin.x = (superFrame.size.width/2) - (frame.size.width/2);
    self.frame = frame;
}


-(void)centerInsideFrame:(CGRect)superFrame
{
    CGRect frame =self.frame;
    frame.origin.x = (superFrame.size.width/2) - (frame.size.width/2);
    frame.origin.y = (superFrame.size.height/2) - (frame.size.height/2);
    self.frame = frame;
}

-(void)shiftFrameY:(CGFloat)shift
{
    CGRect frame =self.frame;
    frame.origin.y+=shift;
    self.frame = frame;
}

-(void)shiftFrameX:(CGFloat)shift
{
    CGRect frame =self.frame;
    frame.origin.x+=shift;
    self.frame = frame;
}

-(void)shiftFrameWidth:(CGFloat)shift
{
    CGRect frame =self.frame;
    frame.size.width+=shift;
    self.frame = frame;
}

-(void)shiftFrameHeight:(CGFloat)shift
{
    CGRect frame =self.frame;
    frame.size.height+=shift;
    self.frame = frame;
}

-(void)setSQFrame:(CGFloat)shift
{
    CGRect frame =self.frame;
    frame.size.height=shift;
    frame.size.width=shift;
    self.frame = frame;
}

-(void)setZeroPos
{
    CGRect frame =self.frame;
    frame.origin.x=0;
    frame.origin.y=0;
    self.frame = frame;
}

-(void)setZeroSize
{
    CGRect frame =self.frame;
    frame.size.width=0;
    frame.size.height=0;
    self.frame = frame;
}


@end
