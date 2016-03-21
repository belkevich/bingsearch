//
//  WebSearchHTMLParser.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 21.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

class WebSearchHTMLParser
{
    var html: NSString! = nil
    var scanner: NSScanner! = nil
}

extension WebSearchHTMLParser: HTMLParser
{
    func parseData(data: NSData) -> [SearchResult]?
    {
        html = NSString(data: data, encoding: NSUTF8StringEncoding)
        scanner = NSScanner(string: html)
        return nil
    }
}
