//
//  LUStringUtilsTest.m
//
//  Lunar Unity Mobile Console
//  https://github.com/SpaceMadness/lunar-unity-console
//
//  Copyright 2019 Alex Lementuev, SpaceMadness.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import <XCTest/XCTest.h>

#import "Lunar.h"

inline static BOOL isEpsilonEqual(float a, float b)
{
    return fabsf(a - b) < 0.00001f;
}

@interface LUStringUtilsTest : XCTestCase

@end

@implementation LUStringUtilsTest

#pragma mark -
#pragma mark Integers

- (void)testParseInteger
{
    NSInteger result = 0;
    XCTAssertTrue(LUStringTryParseInteger(@"123456", &result));
    XCTAssertEqual(123456, result);
}

- (void)testParseNegativeInteger
{
    NSInteger result = 0;
    XCTAssertTrue(LUStringTryParseInteger(@"-123456", &result));
    XCTAssertEqual(-123456, result);
}

- (void)testParseInvalidInteger
{
    NSInteger result = 0;
    XCTAssertFalse(LUStringTryParseInteger(@"x123456", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"123x456", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"123456x", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"", &result));
}

- (void)testParseFloatAsInteger
{
    NSInteger result = 0;
    XCTAssertFalse(LUStringTryParseInteger(@"3.14", &result));
}

#pragma mark -
#pragma mark Floats

- (void)testParseFloat
{
    float result = 0;
    XCTAssertTrue(LUStringTryParseFloat(@"123.456", &result));
    XCTAssertTrue(isEpsilonEqual(123.456, result));
}

- (void)testParseNegativeFloat
{
    float result = 0;
    XCTAssertTrue(LUStringTryParseFloat(@"-123.456", &result));
    XCTAssertTrue(isEpsilonEqual(-123.456, result));
}

- (void)testParseInvalidFloat
{
    NSInteger result = 0;
    XCTAssertFalse(LUStringTryParseInteger(@"x123.456", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"12.3x456", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"123.456x", &result));
    XCTAssertFalse(LUStringTryParseInteger(@"", &result));
}

#pragma mark -
#pragma mark Serialization

- (void)testDictionaryToStringSerialization
{
    NSDictionary *dict = @{
       @"key1" : @"value",
       @"key2" : @"value with whitespace",
       @"key3" : @"value with\nlinebreak",
       @"key4" : @"value with \"quotes\"",
       @"key5" : @"value with: separator",
       @"key6" : @""
    };
    
    NSString *expected = @"key3:value with\\nlinebreak\nkey1:value\nkey6:\nkey4:value with \"quotes\"\nkey2:value with whitespace\nkey5:value with: separator";
    NSString *actual = LUSerializeDictionaryToString(dict);
    
    XCTAssertEqualObjects(expected, actual);
}

@end
