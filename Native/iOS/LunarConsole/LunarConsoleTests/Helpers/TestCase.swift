//
//  TestCase.swift
//  LunarConsoleTests
//
//  Created by Alex Lementuev on 12/8/18.
//  Copyright © 2018 Space Madness. All rights reserved.
//

import XCTest

class TestCase: XCTestCase {
	private var result = [String]()
	
	func addResult(_ obj: String) {
		result.append(obj)
	}
	
	func assertResult(expected: String...) {
		let message = "Expected: '\(expected.joined(separator: ","))' but was '\(result.joined(separator: ","))'"
		XCTAssertEqual(expected.count, result.count, message)
		
		if expected.count == result.count {
			for i in 0..<expected.count {
				XCTAssertEqual(expected[i], result[i], message)
			}
		}
		
		result.removeAll()
	}
}
