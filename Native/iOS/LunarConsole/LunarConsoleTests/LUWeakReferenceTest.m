//
//  LUWeakReferenceTest.m
//  LunarConsoleTests
//
//  Created by Alex Lementuev on 12/12/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TestCase.h"

#import "Lunar.h"

@interface LUWeakReferenceTest : TestCase

@end

@implementation LUWeakReferenceTest

- (void)testStrongReference {
	NSObject *target = [[NSObject alloc] init];
	LUWeakReference *reference = [LUWeakReference referenceWithTarget:target];
	XCTAssertFalse(reference.isLost);
	XCTAssertEqualObjects(reference.target, target);
}

- (void)testWeakReference {
	LUWeakReference *reference;
	
	@autoreleasepool {
		NSObject *target = [[NSObject alloc] init];
		reference = [LUWeakReference referenceWithTarget:target];
		XCTAssertFalse(reference.isLost);
		XCTAssertEqualObjects(reference.target, target);
	}
	
	XCTAssertTrue(reference.isLost);
	XCTAssertNil(reference.target);
}

@end
