//
//  LUWeakReference.m
//  LunarConsole
//
//  Created by Alex Lementuev on 12/12/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import "LUWeakReference.h"

@implementation LUWeakReference

+ (instancetype)referenceWithTarget:(id)target
{
	return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target
{
	self = [super init];
	if (self)
	{
		_target = target;
	}
	return self;
}

- (BOOL)isLost
{
	return _target == nil;
}

@end
