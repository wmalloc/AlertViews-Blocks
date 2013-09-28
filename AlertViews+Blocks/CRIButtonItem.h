//
//  CRIButtonItem.h
//  AlertView
//
//  Created by Waqar Malik on 5/23/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CRIButtonItemActionRef)(void);

@interface CRIButtonItem : NSObject
@property (copy, nonatomic) NSString *label;
@property (copy, nonatomic) CRIButtonItemActionRef action;

+ (instancetype)buttonItem;
+ (instancetype)buttonItemWithLabel:(NSString *)label;
- (instancetype)initWithLabel:(NSString *)label;
@end
