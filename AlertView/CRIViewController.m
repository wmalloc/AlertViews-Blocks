//
//  CRIViewController.m
//  AlertView
//
//  Created by Waqar Malik on 5/22/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import "CRIViewController.h"
#import "CRIButtonItem.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"
@interface CRIViewController () <UIAlertViewDelegate, UIActionSheetDelegate>

@end

@implementation CRIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alert1:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [alertView show:^(NSUInteger buttonIndex) {
        NSLog(@"Button Pressed = %d", buttonIndex);
    }];
}

- (IBAction)alert2:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Pressed = %d", buttonIndex);
}

- (IBAction)alert3:(id)sender
{
    CRIButtonItem *doneItem = [CRIButtonItem buttonItemWithLabel:@"Done"];
    doneItem.action = ^{
        NSLog(@"Done");
    };

    CRIButtonItem *cancelItem = [CRIButtonItem buttonItemWithLabel:@"Cancel"];
    cancelItem.action = ^{
        NSLog(@"Cancel");
    };

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" cancelButtonItem:cancelItem otherButtonItems:doneItem, nil];
    [alertView show:^(NSUInteger buttonIndex) {
        NSLog(@"Button index = %d", buttonIndex);
    }];
}

- (IBAction)action1:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove" otherButtonTitles:nil, nil];
    [sheet showInView:self.view dismissAction:^(NSUInteger buttonIndex) {
        NSLog(@"Button Pressed = %d", buttonIndex);
    }];
}

- (IBAction)action2:(id)sender
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Title" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Remove" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Pressed = %d", buttonIndex);
}

- (IBAction)action3:(id)sender
{
    CRIButtonItem *removeItem = [CRIButtonItem buttonItemWithLabel:@"Remove"];
    removeItem.action = ^{
        NSLog(@"Remove");
    };

    CRIButtonItem *cancelItem = [CRIButtonItem buttonItemWithLabel:@"Cancel"];
    cancelItem.action = ^{
        NSLog(@"Cancel");
    };

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Title" cancelButtonItem:cancelItem destructiveButtonItem:removeItem otherButtonItems:nil, nil];
    [sheet showInView:self.view dismissAction:^(NSUInteger buttonIndex) {
        NSLog(@"Button Pressed = %d", buttonIndex);
    }];
}
@end
