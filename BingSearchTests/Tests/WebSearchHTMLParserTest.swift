//
//  WebSearchHTMLParserTest.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 21.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import XCTest
import Nimble
@testable import BingSearch

class WebSearchHTMLParserTest: XCTestCase
{
    let bundle = NSBundle(identifier: "test.BingSearchTests")!
    var parser: WebSearchHTMLParser!

    func testParsing()
    {
        super.setUp()
        parser = WebSearchHTMLParser()
        let path = bundle.pathForResource("webSearch.html", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        let result = parser.parseData(data!)
        expect(result).toNot(beNil())
    }
}
