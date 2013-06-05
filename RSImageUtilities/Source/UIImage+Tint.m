//
//  UIImage+Tint.m
//
//  Created by Matt Gemmell on 04/07/2010.
//  Copyright 2010 Instinctive Code.
//

#import "UIImage+Tint.h"


@implementation UIImage (MGTint)

//Tinting images

- (UIImage *)imageTintedWithColor:(UIColor *)color
{
	// This method is designed for use with template images, i.e. solid-coloured mask-like images.
	return [self imageTintedWithColor:color fraction:0.0]; // default to a fully tinted mask of the image.
}


- (UIImage *)imageTintedWithColor:(UIColor *)color fraction:(CGFloat)fraction
{
	if (color) {
		// Construct new image the same size as this one.
		UIImage *image;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
		if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
			UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
		} else {
			UIGraphicsBeginImageContext([self size]);
		}
#else
		UIGraphicsBeginImageContext([self size]);
#endif
		CGRect rect = CGRectZero;
		rect.size = [self size];
		
		// Composite tint color at its own opacity.
		[color set];
		UIRectFill(rect);
		
		// Mask tint color-swatch to this image's opaque mask.
		// We want behaviour like NSCompositeDestinationIn on Mac OS X.
		[self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
		
		// Finally, composite this image over the tinted mask at desired opacity.
		if (fraction > 0.0) {
			// We want behaviour like NSCompositeSourceOver on Mac OS X.
			[self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:fraction];
		}
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		return image;
	}
	
	return self;
}

//Adding dropshadows to images

- (UIImage *)imageWithShadow:(CGSize)shadow {
    return [self imageWithShadow:shadow blur:2];
}

- (UIImage *)imageWithShadow:(CGSize)shadow blur:(CGFloat)blur {
    return [self imageWithShadow:shadow blur:blur color:[UIColor blackColor]];
}

- (UIImage *)imageWithShadow:(CGSize)shadow blur:(CGFloat)blur color:(UIColor *)color {
    float scaleFactor = [[UIScreen mainScreen] scale];
    
    if(scaleFactor > 1.0) {
        shadow.width = shadow.width*scaleFactor;
        shadow.height = shadow.height*scaleFactor;
        blur = blur*scaleFactor;
    }
    
    float width = (self.size.width*scaleFactor)+shadow.width+(blur*2);
    float x = (shadow.width/scaleFactor)+(blur/2);
    if(shadow.width < 0) {
        x =  ((shadow.width*-1)/scaleFactor)+(blur/2);
        width =(self.size.width*scaleFactor)+(shadow.width*-1)+(blur*2);
    }
    float height = (self.size.height*scaleFactor)+shadow.height+(blur*2);
    float y = (shadow.height/scaleFactor)+(blur/2);
    if(shadow.height < 0) {
        y = ((shadow.height*-1)/scaleFactor)+(blur/2);
        height =(self.size.height*scaleFactor)+(shadow.height*-1)+(blur*2);
    }
    
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef shadowContext = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(self.CGImage), 0, colourSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextScaleCTM(shadowContext, scaleFactor, scaleFactor);
    
    CGColorSpaceRelease(colourSpace);
    
    CGContextSetShadowWithColor(shadowContext, shadow, blur, color.CGColor);
    CGContextDrawImage(shadowContext, CGRectMake(x, y, self.size.width, self.size.height), [self CGImage]);
    
    CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
    CGContextRelease(shadowContext);
    
    UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage scale:scaleFactor orientation:UIImageOrientationUp];
    CGImageRelease(shadowedCGImage);
    
    return shadowedImage;
}

//Combining tinting and adding shadows

- (UIImage *)imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow {
    UIImage *image = [self imageTintedWithColor:color fraction:0.0];
    return [image imageWithShadow:CGSizeMake(0, -1) blur:2];
}

- (UIImage *)imageTintedWithColor:(UIColor *)color shadow:(CGSize)shadow shadowColor:(UIColor *)shadowColor {
    UIImage *image = [self imageTintedWithColor:color fraction:0.0];
    return [image imageWithShadow:CGSizeMake(0, -1) blur:2 color:shadowColor];
}

//Adding rounded corners

- (UIImage *)imageWithRoundedCorners:(CGFloat)radius {
    return [self imageWithRoundedCorners:UIRectCornerAllCorners radii:CGSizeMake(radius, radius)];
}

- (UIImage *)imageWithRoundedCorners:(UIRectCorner)corners radii:(CGSize)radii {
    // Get your image somehow
    UIImage *newImage = nil;
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.f);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii] addClip];
    // Draw your image
    [self drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return newImage;
}

//Creating image for a certain width

- (UIImage *)imageForWidth:(CGFloat)width {
    // Get your image somehow
    UIImage *newImage = nil;
    CGRect rect = CGRectMake(0, 0, width, self.size.height);
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.f);
    // Draw your image
    [self drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage *)imageInRect:(CGRect)rect {
    CGRect imageRect = rect;
    if([[UIScreen mainScreen] scale] != 1.0) {
        imageRect.origin.x = imageRect.origin.x*[[UIScreen mainScreen] scale];
        imageRect.origin.y = imageRect.origin.y*[[UIScreen mainScreen] scale];
        imageRect.size.width = imageRect.size.width*[[UIScreen mainScreen] scale];
        imageRect.size.height = imageRect.size.height*[[UIScreen mainScreen] scale];
    }
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect( [self CGImage] , imageRect )];
}

//Image centered

-(UIImage *)imageCenteredInSize:(CGSize)size backgroundColor:(UIColor *)color {
    if (!color) {
        color = [[self getRGBAsAtPoint:CGPointMake(0, 0) count:1] objectAtIndex:0];
    }
    // Get your image somehow
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    // Draw your image
    CGRect drawRect = CGRectMake((size.width-imageSize.width)/2, (size.height-imageSize.height)/2, imageSize.width, imageSize.height);
    [self drawInRect:drawRect];
    
    // Get the image, here setting the UIImageView image
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return newImage;
}

//Get RGB value at cerain point in images (WARNING: Heavy code, only use when needed)

- (NSArray *)getRGBAsAtPoint:(CGPoint)point count:(int)count
{
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [self CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    for (int ii = 0 ; ii < count ; ++ii)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
        byteIndex += 4;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
    
    free(rawData);
    
    return result;
}

//Creating a black image

+ (UIImage *)createBlackImageWithSize:(CGSize)size
{
    return [self createImageWithSize:size color:[UIColor blackColor]];
}

+ (UIImage *)createWhiteImageWithSize:(CGSize)size
{
    return [self createImageWithSize:size color:[UIColor whiteColor]];
}

+ (UIImage *)createImageWithSize:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContext(size);
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor);
    CGContextFillRect (UIGraphicsGetCurrentContext(), CGRectMake (0, 0, size.width, size.height));
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//Private: creating an inverted mask for inner shadows

- (UIImage*) createInvertMask:(UIImage *)maskImage color:(UIColor *)color {
    
    CGSize maskImageSize = maskImage.size;
    UIImage *targetImage = [UIImage createImageWithSize:maskImageSize color:color];
    CGRect imageRect = CGRectMake(1, 1, maskImageSize.width, maskImageSize.height);
    
    CGContextRef oldContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(oldContext);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO,0.f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, imageRect, targetImage.CGImage);
    
    CGContextTranslateCTM(context, 0.0f, maskImageSize.height);
	CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    CGContextDrawImage(context, imageRect, maskImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGContextRestoreGState(oldContext);
    
    return newImage;
}

//Adding inner shadows to images

- (UIImage *)imageWithInnerShadowColor:(UIColor *)color {
    return [self imageWithInnerShadowColor:color blur:5];
}

- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur {
    return [self imageWithInnerShadowColor:color blur:blur offset:CGSizeMake(0, 0)];
}

- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset {
    return [self imageWithInnerShadowColor:color blur:blur offset:offset maskColor:[UIColor whiteColor]];
}

- (UIImage *)imageWithInnerShadowColor:(UIColor *)color blur:(CGFloat)blur offset:(CGSize)offset maskColor:(UIColor *)maskColor {
    if(color) {
        // Construct new image the same size as this one.
        UIImage *image;
        
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGRect rect = CGRectZero;
        rect.size = [self size];
        
        CGContextTranslateCTM(context, 0.0f, self.size.height);
        CGContextScaleCTM(context, 1.0f, -1.0f);
        
        // Draw the original image
        CGContextDrawImage(context, rect, self.CGImage);
        
        // Clip to the original image, so that we only draw the shadows on the
        // inside of the image but nothing outside.
        CGContextClipToMask(context, rect, self.CGImage);
        // Set up the shadow
        CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
        
        // Create a mask with an inverted alpha channel and draw it. This will
        // cause the shadow to appear on the inside of our original image.
        CGImageRef mask = [[self createInvertMask:self color:maskColor] CGImage];
        
        CGContextDrawImage(context, rect, mask);
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return image;
    } else {
        return nil;
    }
}

//Adding gradients to images

- (UIImage *)imageWithGradient:(NSArray *)colors {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *gradientColors = [NSMutableArray array];
    for(id object in colors) {
        if([object isKindOfClass:[UIColor class]]) {
            UIColor *color = (UIColor *)object;
            [gradientColors addObject:(id)color.CGColor];
        }
    }
    if([gradientColors count] < 2) {
        NSAssert(NO,@"Not enough colors");
    }
    
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.f); // 0.f for scale means "scale for device's main screen".
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFMutableArrayRef) gradientColors, NULL);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    
    CGContextTranslateCTM(context, 0.0f, self.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextDrawImage(context, rect, self.CGImage);
    
    CGContextClipToMask(context,rect, self.CGImage);
    CGContextDrawLinearGradient(context, gradient, endPoint, startPoint, 0);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
