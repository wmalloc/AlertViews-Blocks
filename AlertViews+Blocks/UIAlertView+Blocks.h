//
//  UIAlertView+Blocks.h
//  AlertView
//
//  Created by Waqar Malik on 5/22/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRIButtonItem;

typedef void (^CRIAlertViewDismissActionRef)(NSUInteger buttonIndex);

@interface UIAlertView (Blocks) <UIAlertViewDelegate>

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(CRIButtonItem *)cancelButtonItem otherButtonItems:(CRIButtonItem *)otherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonItem:(CRIButtonItem *)cancelButtonItem otherButtonItemsArray:(NSArray *)otherButtonItemsArray;

- (NSInteger)addButtonItem:(CRIButtonItem *)item;

- (void)show:(CRIAlertViewDismissActionRef)dismissAction;
@end
