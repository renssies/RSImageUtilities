//
//  RSViewController.m
//  InnserShadow
//
//  Created by Rens Verhoeven on 16-05-13.
//  Copyright (c) 2013 Awkward. All rights reserved.
//

#import "RSViewController.h"
#import "MGImageUtilities.h"

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
    UIImage *person = [UIImage imageNamed:@"icon-person-jumbo.png"];
    [_imageView setImage:person];
}

- (IBAction)centerOnBackground:(id)sender {
    UIImage *image = [_imageView image];
    image = [image imageCenteredInSize:_imageView.bounds.size backgroundColor:[UIColor brownColor]];
    [_imageView setImage:image];
}

- (IBAction)blackImage:(id)sender {
    UIImage *image = [UIImage createBlackImageWithSize:_imageView.bounds.size];
    [_imageView setImage:image];
}

- (IBAction)shadow:(id)sender {
    UIImage *image = [_imageView image];
    image = [image imageWithShadow:CGSizeMake(0, 0) blur:10 color:[UIColor darkGrayColor]];
    [_imageView setImage:image];
}

- (IBAction)innerShadow:(id)sender {
    UIImage *image = [_imageView image];
    image = [image imageWithInnerShadowColor:[UIColor colorWithWhite:0 alpha:0.5f] blur:2 offset:CGSizeMake(0, 0) maskColor:self.view.backgroundColor];
    [_imageView setImage:image];
}

- (IBAction)gradient:(id)sender {
    UIImage *image = [_imageView image];
    image = [image imageWithGradient:@[[UIColor greenColor],[UIColor blueColor]]];
    [_imageView setImage:image];
}

- (IBAction)tint:(id)sender {
    UIImage *image = [_imageView image];
    image = [image imageTintedWithColor:[UIColor greenColor]];
    [_imageView setImage:image];
}


@end
