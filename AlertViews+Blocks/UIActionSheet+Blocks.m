//
//  UIActionSheet+Blocks.m
//  AlertView
//
//  Created by Waqar Malik on 5/23/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "CRIButtonItem.h"
#import "UIActionSheet+Blocks.h"

@implementation UIActionSheet (Blocks)
#pragma mark - Object Lifecycle
- (instancetype)initWithTitle:(NSString *)title cancelButtonItem:(CRIButtonItem *)cancelButtonItem destructiveButtonItem:(CRIButtonItem *)destructiveItem otherButtonItems:(CRIButtonItem *)otherButtonItems, ...
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
    return [self initWithTitle:title cancelButtonItem:cancelButtonItem destructiveButtonItem:destructiveItem otherButtonItemsArray:buttonsArray];
}

- (instancetype)initWithTitle:(NSString *)title cancelButtonItem:(CRIButtonItem *)cancelButtonItem destructiveButtonItem:(CRIButtonItem *)destructiveItem otherButtonItemsArray:(NSArray *)otherButtonItemsArray
{
    if((self = [self initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil]))
    {
        NSMutableArray *buttonsArray = [NSMutableArray arrayWithArray:otherButtonItemsArray];

        for(CRIButtonItem *item in buttonsArray)
        {
            [self addButtonWithTitle:item.label];
        }

        if(destructiveItem)
        {
            [buttonsArray addObject:destructiveItem];
            NSInteger destIndex = [self addButtonWithTitle:destructiveItem.label];
            [self setDestructiveButtonIndex:destIndex];
        }

        if(cancelButtonItem)
        {
            [buttonsArray addObject:cancelButtonItem];
            NSInteger cancelIndex = [self addButtonWithTitle:cancelButtonItem.label];
            [self setCancelButtonIndex:cancelIndex];
        }
        self.buttonsArray = buttonsArray;
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
    NSMutableArray *buttonsArray = self.buttonsArray;

	NSInteger buttonIndex = [self addButtonWithTitle:item.label];
	[buttonsArray addObject:item];

	return buttonIndex;
}

#pragma mark - Actions
- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated dismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self showFromBarButtonItem:item animated:animated];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated dismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self showFromRect:rect inView:view animated:animated];
}

- (void)showFromTabBar:(UITabBar *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self showFromTabBar:view];
}

- (void)showFromToolbar:(UIToolbar *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self showFromToolbar:view];
}

- (void)showInView:(UIView *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    self.dismissAction = dismissAction;
    self.delegate = self;
    [self showInView:view];
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

- (CRIActionSheetDismissActionRef)dismissAction
{
    return (CRIActionSheetDismissActionRef)objc_getAssociatedObject(self, @selector(dismissAction));
}

- (void)setDismissAction:(CRIActionSheetDismissActionRef)dismissAction
{
    CRIActionSheetDismissActionRef localBlock = [dismissAction copy];
    objc_setAssociatedObject(self, @selector(dismissAction), localBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
#pragma unused(actionSheet)
    if(buttonIndex != -1)
    {
        NSArray *buttonsArray = [self buttonsArray];
        CRIButtonItem *item = buttonsArray[buttonIndex];
        if(item.action)
        {
            item.action();
        }
    }

    [self setButtonsArray:nil];

    CRIActionSheetDismissActionRef dismissBlock = self.dismissAction;
    [self setDismissAction:NULL];
    if(NULL != dismissBlock)
    {
        dismissBlock(buttonIndex);
    }
    dismissBlock = nil;
}
@end
