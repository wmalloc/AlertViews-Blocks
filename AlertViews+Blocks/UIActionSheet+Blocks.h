//
//  UIActionSheet+Blocks.h
//  AlertView
//
//  Created by Waqar Malik on 5/23/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRIButtonItem;

typedef void (^CRIActionSheetDismissActionRef)(NSUInteger buttonIndex);

@interface UIActionSheet (Blocks) <UIActionSheetDelegate>
- (instancetype)initWithTitle:(NSString *)title cancelButtonItem:(CRIButtonItem *)cancelButtonItem destructiveButtonItem:(CRIButtonItem *)destructiveItem otherButtonItems:(CRIButtonItem *)otherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithTitle:(NSString *)title cancelButtonItem:(CRIButtonItem *)cancelButtonItem destructiveButtonItem:(CRIButtonItem *)destructiveItem otherButtonItemsArray:(NSArray *)otherButtonItemsArray;

- (NSInteger)addButtonItem:(CRIButtonItem *)item;

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated dismissAction:(CRIActionSheetDismissActionRef)dismissAction;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated dismissAction:(CRIActionSheetDismissActionRef)dismissAction;
- (void)showFromTabBar:(UITabBar *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction;
- (void)showFromToolbar:(UIToolbar *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction;
- (void)showInView:(UIView *)view dismissAction:(CRIActionSheetDismissActionRef)dismissAction;
@end
