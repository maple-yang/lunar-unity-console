//
//  LUPlayerPrefsTest.swift
//  LunarConsole
//
//  Created by Alex Lementuev on 8/29/17.
//  Copyright © 2017 Space Madness. All rights reserved.
//

import XCTest

class LUPlayerPrefsTest: XCTestCase
{
	private var prefs: LUPlayerPrefs!
	
    override func setUp()
	{
        super.setUp()
		let bundle = Bundle(for: type(of: self))
		let path = bundle.path(forResource: "PlayerPrefs", ofType: "plist")
		prefs = LUPlayerPrefs(path: path)
    }
    
    func testLoading() {
        XCTAssertTrue(prefs.load())
		let entries = prefs.entries!
		XCTAssertEqual(3, entries.count)
		
		XCTAssertEqual(LUPlayerPrefsEntryTypeString, entries[0].type)
		XCTAssertEqual("String value", entries[0].stringValue)
		
		XCTAssertEqual(LUPlayerPrefsEntryTypeInteger, entries[1].type)
		XCTAssertEqual(10, entries[1].intValue)
		
		XCTAssertEqual(LUPlayerPrefsEntryTypeFloat, entries[2].type)
		XCTAssertEqual(3.14, entries[2].floatValue)
    }
}
