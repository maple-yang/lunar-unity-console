//
//  LUObservable.m
//  LunarConsole
//
//  Created by Alex Lementuev on 12/8/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import "LUObservable.h"
#import "LUAssert.h"
#import "LUWeakReference.h"

@interface LUBlockObserver ()

@property (nonatomic, copy) void(^block)(id value);

@end

@implementation LUBlockObserver

+ (instancetype)observerWithBlock:(void(^)(id value))block
{
	return [[self alloc] initWithBlock:block];
}

- (instancetype)initWithBlock:(void(^)(id value))block
{
	self = [super init];
	if (self) {
		self.block = block;
	}
	return self;
}

#pragma mark -
#pragma mark LUObserver

- (void)valueDidChage:(nullable id)value
{
	_block(value);
}

@end

@interface LUObservable ()
{
	id _target;
	NSMutableArray<LUWeakReference *> * _observers;
}
@end

@implementation LUObservable

+ (instancetype)observableWithTarget:(id)target
{
	return [[self alloc] initWithTarget:target];
}

- (instancetype)initWithTarget:(id)target
{
	self = [super init];
	if (self)
	{
		_target = target;
		_observers = [NSMutableArray new];
	}
	return self;
}

#pragma mark -
#pragma mark Observers

- (void)addObserver:(id<LUObserver>)observer
{
	LUAssert(observer);
	
	for (LUWeakReference *reference in _observers)
	{
		id<LUObserver> existingObserver = reference.target;
		if (observer == existingObserver)
		{
			return;
		}
	}
	
	[_observers addObject:[LUWeakReference referenceWithTarget:observer]];
	[observer valueDidChage:_target];
}

- (void)removeObserver:(id<LUObserver>)observer
{
	for (LUWeakReference *reference in _observers)
	{
		id<LUObserver> existingObserver = reference.target;
		if (observer == existingObserver)
		{
			[_observers removeObject:reference];
			return;
		}
	}
}

- (void)notifyObservers
{
	NSUInteger lostReferenceCount = 0;
	for (LUWeakReference *reference in _observers)
	{
		id<LUObserver> observer = reference.target;
		if (observer == nil)
		{
			lostReferenceCount++;
			continue;
		}
		
		[observer valueDidChage:_target];
	}
	
	for (NSUInteger i = _observers.count - 1; i >= 0 && lostReferenceCount > 0; --i)
	{
		if (_observers[i].isLost)
		{
			[_observers removeObjectAtIndex:i];
			lostReferenceCount--;
		}
	}
}

#pragma mark -
#pragma mark Properties

- (void)setTarget:(id)target
{
	_target = target;
	[self notifyObservers];
}

@end
