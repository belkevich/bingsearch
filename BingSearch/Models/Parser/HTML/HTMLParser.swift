//
//  HTMLParser.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 21.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

protocol HTMLParser
{
    func parseData(data: NSData) -> [SearchResult]?
}
