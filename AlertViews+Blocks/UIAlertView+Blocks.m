//
//  UIAlertView+Blocks.m
//  AlertView
//
//  Created by Waqar Malik on 5/22/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "CRIButtonItem.h"
#import "UIAlertView+Blocks.h"

@implementation UIAlertView (Blocks)
#pragma mark - Object Lifecycle
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(CRIButtonItem *)cancelButtonItem otherButtonItems:(CRIButtonItem *)otherButtonItems, ...
{
    NSMutableArray *buttonsArray = [NSMutableArray array];

    CRIButtonItem *eachItem = nil;
    va_list argumentList;
    if(otherButtonItems)
    {
        [buttonsArray addObject:otherButtonItems];
        va_start(argumentList, otherButtonItems);
        while((eachItem = va_arg(argumentList, CRIButtonItem *)))
        {
            [buttonsArray addObject:eachItem];
        }
        va_end(argumentList);
    }
    return [self initWithTitle:title message:message cancelButtonItem:cancelButtonItem otherButtonItemsArray:buttonsArray];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(CRIButtonItem *)cancelButtonItem otherButtonItemsArray:(NSArray *)otherButtonItemsArray
{
    if((self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonItem.label otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray arrayWithArray:otherButtonItemsArray];

        for(CRIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }

        if(cancelButtonItem)
        {
            [buttonsArray insertObject:cancelButtonItem atIndex:0];
        }

        [self setButtonsArray:buttonsArray];
        [self setDelegate:self];
    }
    return self;
}

- (void)dealloc
{
    [self setDismissAction:NULL];
    [self setButtonsArray:nil];
}

#pragma mark - Methods
- (NSInteger)addButtonItem:(CRIButtonItem *)item
{
    NSMutableArray *buttonsArray = [self buttonsArray];

	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];

	return buttonIndex;
}

#pragma mark - Actions
- (void)show:(CRIAlertViewDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self show];
}

#pragma mark - Dynamic Properties
- (NSMutableArray *)buttonsArray
{
    return (NSMutableArray *)objc_getAssociatedObject(self, @selector(buttonsArray));
}

- (void)setButtonsArray:(NSMutableArray *)buttonsArray
{
    objc_setAssociatedObject(self, @selector(buttonsArray), buttonsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CRIAlertViewDismissActionRef)dismissAction
{
    return (CRIAlertViewDismissActionRef)objc_getAssociatedObject(self, @selector(dismissAction));
}

- (void)setDismissAction:(CRIAlertViewDismissActionRef)dismissBlock
{
    CRIAlertViewDismissActionRef localBlock = [dismissBlock copy];
    objc_setAssociatedObject(self, @selector(dismissAction), localBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
#pragma unused(alertView)
    NSMutableArray *buttonsArray = [self buttonsArray];
    CRIButtonItem *item = buttonsArray[buttonIndex];
    if(item.action)
    {
        item.action();
    }
    
    [self setButtonsArray:nil];

    CRIAlertViewDismissActionRef dismissBlock = self.dismissAction;
    [self setDismissAction:NULL];
    if(NULL != dismissBlock)
    {
        dismissBlock(buttonIndex);
    }
    dismissBlock = nil;
}
@end
