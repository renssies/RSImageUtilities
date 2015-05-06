//
//  RSViewController.m
//  InnserShadow
//
//  Created by Rens Verhoeven on 16-05-13.
//  Copyright (c) 2013 Awkward. All rights reserved.
//

#import "RSViewController.h"
#import "RSImageUtilities.h"

@interface RSViewController ()

@end

@implementation RSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self person:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)person:(id)sender {
    UIImage *person = [UIImage imageNamed:@"icon-person"];
    [_imageView setImage:person];
}

- (IBAction)blackImage:(id)sender {
    UIImage *image = [UIImage rs_createBlackImageWithSize:_imageView.bounds.size];
    [_imageView setImage:image];
}

- (IBAction)centerOnBackground:(id)sender {
    UIImage *image = [_imageView image];
    image = [image rs_imageCenteredInSize:_imageView.bounds.size backgroundColor:[UIColor brownColor]];
    [_imageView setImage:image];
}

- (IBAction)shadow:(id)sender {
    UIImage *image = [_imageView image];
    image = [image rs_imageWithShadow:CGSizeMake(0, 0) blur:10 color:[UIColor darkGrayColor]];
    [_imageView setImage:image];
}

- (IBAction)gradient:(id)sender {
    UIImage *image = [_imageView image];
    image = [image rs_imageWithGradient:@[[UIColor greenColor],[UIColor blueColor]]];
    [_imageView setImage:image];
}

- (IBAction)tint:(id)sender {
    UIImage *image = [_imageView image];
    image = [image rs_imageTintedWithColor:[UIColor greenColor]];
    [_imageView setImage:image];
}

- (IBAction)innerShadow:(id)sender {
    UIImage *image = [_imageView image];
    image = [image rs_imageWithInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.5f] blur:2 offset:CGSizeMake(0, 0) maskColor:self.view.backgroundColor];
    [_imageView setImage:image];
}


@end
