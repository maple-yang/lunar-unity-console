//
//  LUCVarTest.m
//  LunarConsoleTests
//
//  Created by Alex Lementuev on 1/2/19.
//  Copyright © 2019 Space Madness. All rights reserved.
//

#import "TestCase.h"

@interface LUCVarTest : TestCase

@end

@implementation LUCVarTest

- (void)testInitialization
{
	LUCVar *cvar = [LUCVar variableWithId:0 name:@"name" value:@"value" defaultValue:@"defaultValue" type:LUCVarTypeString cellClass:nil];
	XCTAssertEqual(cvar.type, LUCVarTypeString);
	XCTAssertEqualObjects(cvar.name, @"name");
	XCTAssertEqualObjects(cvar.value, @"value");
	XCTAssertEqualObjects(cvar.defaultValue, @"defaultValue");
	XCTAssertFalse(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 0);
	XCTAssertEqual(cvar.floatValue, 0.0);
	XCTAssertFalse(cvar.boolValue);
}

- (void)testDefaultValue
{
	LUCVar *cvar = [LUCVar variableWithId:0 name:@"name" value:@"value" defaultValue:@"defaultValue" type:LUCVarTypeString cellClass:nil];
	XCTAssertFalse(cvar.isDefaultValue);
	[cvar resetToDefaultValue];
	XCTAssertEqualObjects(cvar.value, @"defaultValue");
	XCTAssertTrue(cvar.isDefaultValue);
}

- (void)testIntValue
{
	LUCVar *cvar = [LUCVar variableWithId:0 name:@"name" value:@"10" defaultValue:@"20" type:LUCVarTypeInteger cellClass:nil];
	XCTAssertEqual(cvar.type, LUCVarTypeInteger);
	XCTAssertEqualObjects(cvar.name, @"name");
	XCTAssertEqualObjects(cvar.value, @"10");
	XCTAssertEqualObjects(cvar.defaultValue, @"20");
	XCTAssertFalse(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 10);
	XCTAssertEqual(cvar.floatValue, 10.0);
	[cvar resetToDefaultValue];
	XCTAssertEqualObjects(cvar.value, @"20");
	XCTAssertTrue(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 20);
	XCTAssertEqual(cvar.floatValue, 20.0);
}

- (void)testFloatValue
{
	LUCVar *cvar = [LUCVar variableWithId:0 name:@"name" value:@"3.14" defaultValue:@"1.25" type:LUCVarTypeFloat cellClass:nil];
	XCTAssertEqual(cvar.type, LUCVarTypeFloat);
	XCTAssertEqualObjects(cvar.name, @"name");
	XCTAssertEqualObjects(cvar.value, @"3.14");
	XCTAssertEqualObjects(cvar.defaultValue, @"1.25");
	XCTAssertFalse(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 3);
	XCTAssertEqualWithAccuracy(cvar.floatValue, 3.14, 0.00001);
	[cvar resetToDefaultValue];
	XCTAssertEqualObjects(cvar.value, @"1.25");
	XCTAssertTrue(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 1);
	XCTAssertEqualWithAccuracy(cvar.floatValue, 1.25, 0.00001);
}

- (void)testBoolValue
{
	LUCVar *cvar = [LUCVar variableWithId:0 name:@"name" value:@"1" defaultValue:@"0" type:LUCVarTypeBoolean cellClass:nil];
	XCTAssertEqual(cvar.type, LUCVarTypeBoolean);
	XCTAssertEqualObjects(cvar.name, @"name");
	XCTAssertEqualObjects(cvar.value, @"1");
	XCTAssertEqualObjects(cvar.defaultValue, @"0");
	XCTAssertFalse(cvar.isDefaultValue);
	XCTAssertTrue(cvar.boolValue);
	XCTAssertEqual(cvar.intValue, 1);
	XCTAssertEqualWithAccuracy(cvar.floatValue, 1.0, 0.00001);
	[cvar resetToDefaultValue];
	XCTAssertFalse(cvar.boolValue);
	XCTAssertEqualObjects(cvar.value, @"0");
	XCTAssertTrue(cvar.isDefaultValue);
	XCTAssertEqual(cvar.intValue, 0);
	XCTAssertEqualWithAccuracy(cvar.floatValue, 0.0, 0.00001);
}

@end
