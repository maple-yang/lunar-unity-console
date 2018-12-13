//
//  LUObservableTest.m
//  LunarConsoleTests
//
//  Created by Alex Lementuev on 12/12/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import "TestCase.h"
#import "Lunar.h"

@interface LUObservableTest : TestCase

@end

@implementation LUObservableTest

- (void)testExample {
	__weak id weakSelf = self;
	
	id<LUObserver> observer1 = [LUBlockObserver observerWithBlock:^(id _Nonnull value) {
		[weakSelf addResult:[NSString stringWithFormat:@"1: \%@", value]];
	}];
	
	LUObservable *observable = [LUObservable observableWithTarget:@"A"];\
	[observable addObserver:observer1];
	
	[self assertResult:@"1: A"];
	
	observable.target = @"B";
	[self assertResult:@"1: B"];
	
	@autoreleasepool {
		id<LUObserver> observer2 = [LUBlockObserver observerWithBlock:^(id  _Nonnull value) {
			[weakSelf addResult:[NSString stringWithFormat:@"2: %@", value]];
		}];
		
		id<LUObserver> observer3 = [LUBlockObserver observerWithBlock:^(id  _Nonnull value) {
			[weakSelf addResult:[NSString stringWithFormat:@"3: %@", value]];
		}];
		
		[observable addObserver:observer2];
		[observable addObserver:observer2];
		[observable addObserver:observer3];
		
		[self assertResult:@"2: B", @"3: B"];
		
		observable.target = @"C";
		[self assertResult:@"1: C", @"2: C", @"3: C"];
	}
	
	[observable addObserver:observer1];
	
	observable.target = @"D";
	[self assertResult:@"1: D"];
}

@end
