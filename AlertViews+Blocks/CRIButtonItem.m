//
//  CRIButtonItem.m
//  AlertView
//
//  Created by Waqar Malik on 5/23/13.
//  Copyright (c) 2013 Crimson Research, Inc. All rights reserved.
//

#import "CRIButtonItem.h"

@implementation CRIButtonItem
+ (instancetype)buttonItem
{
    return [[self alloc] init];
}

+ (instancetype)buttonItemWithLabel:(NSString *)label
{
    return [[self alloc] initWithLabel:label];
}

- (instancetype)initWithLabel:(NSString *)label
{
    self = [super init];
    if(nil != self)
    {
        _label = [label copy];
    }

    return self;
}

- (void)dealloc
{
    _action = nil;
}
@end
