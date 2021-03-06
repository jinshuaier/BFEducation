//
//  UIView+HBExtension.m
//  嗨豹校园
//
//  Created by 郭志贺 on 2019/7/17.
//  Copyright © 2019 郭志贺. All rights reserved.
//

#import "UIView+HBExtension.h"

@implementation UIView (HBExtension)
// Retrieve and set the origin
- (CGPoint) origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)aPoint {
    
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)aSize {
    
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)bottomRight {
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft {
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight {
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newheight {
    
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}



- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newwidth {
    
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}



- (CGFloat) top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}



- (CGFloat) left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}



- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}



- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}



- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}



- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
@end
