//
//  UIImage+Tint.h
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import <UIKit/UIKit.h>

@interface UIImage (MGTint)

- (UIImage *)imageTintedWithColor:(UIColor *)color;
- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction;

- (UIImage *)imageWithShadow:(CGSize)shadow;
- (UIImage *)imageWithShadow:(CGSize)shadow blur:(CGFloat)blur;
- (UIImage *)imageWithShadow:(CGSize)shadow blur:(CGFloat)blur color:(UIColor *)color;

- (UIImage *)imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow;
- (UIImage *)imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow shadowColor:(UIColor *)shadowColor;

- (UIImage *)imageWithRoundedCorners:(CGFloat)radius;
- (UIImage *)imageWithRoundedCorners:(UIRectCorner)corners radii:(CGSize)radii;
- (UIImage *)imageForWidth:(CGFloat)width;

- (UIImage *)imageCenteredInSize:(CGSize)size backgroundColor:(UIColor *)color;

- (NSArray *)getRGBAsAtPoint:(CGPoint)point count:(int)count;

+ (UIImage *)createBlackImageWithSize:(CGSize)size;
+ (UIImage *)createWhiteImageWithSize:(CGSize)size;
+ (UIImage *)createImageWithSize:(CGSize)size color:(UIColor *)color;

- (UIImage *)imageWithInnerShadowColor:(UIColor *)color;
- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur;
- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset;
- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset maskColor:(UIColor *)maskColor;

- (UIImage *)imageWithGradient:(NSArray *)colors;

//Socialist features

+ (UIImage *)emptyImageWithColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor size:(CGSize)size;
+ (UIImage *)avatarImageWithColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor size:(CGSize)size;
@end
