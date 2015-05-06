//
//  UIImage+Tint.h
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGTint)

- (UIImage *)rs_imageTintedWithColor:(UIColor *)color;
- (UIImage *)rs_imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

- (UIImage *)rs_imageWithShadow:(CGSize)shadow;
- (UIImage *)rs_imageWithShadow:(CGSize)shadow blur:(CGFloat)blur;
- (UIImage *)rs_imageWithShadow:(CGSize)shadow blur:(CGFloat)blur color:(UIColor *)color;

- (UIImage *)rs_imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow;
- (UIImage *)rs_imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow shadowColor:(UIColor *)shadowColor;

- (UIImage *)rs_imageWithRoundedCorners:(CGFloat)radius;
- (UIImage *)rs_imageWithRoundedCorners:(UIRectCorner)corners radii:(CGSize)radii;
- (UIImage *)rs_imageForWidth:(CGFloat)width;

- (UIImage *)rs_imageInRect:(CGRect)rect;

- (UIImage *)rs_imageCenteredInSize:(CGSize)size backgroundColor:(UIColor *)color;

- (NSArray *)rs_getRGBAsAtPoint:(CGPoint)point count:(int)count;

+ (UIImage *)rs_createBlackImageWithSize:(CGSize)size;
+ (UIImage *)rs_createWhiteImageWithSize:(CGSize)size;
+ (UIImage *)rs_createImageWithSize:(CGSize)size color:(UIColor *)color;

- (UIImage *)rs_imageWithInnerShadowColor:(UIColor *)color;
- (UIImage *)rs_imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur;
- (UIImage *)rs_imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset;
- (UIImage *)rs_imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset maskColor:(UIColor *)maskColor;

- (UIImage *)rs_imageWithGradient:(NSArray *)colors;

@end
