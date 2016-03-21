//
//  AsyncParser.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

typealias ParserCompletion = [SearchResult]? -> ()

class AsyncParser
{
    /// mark: public

    func parseData(data: NSData, type: SearchType, completion: ParserCompletion)
    {
        let parser: HTMLParser = type == .Web ? WebSearchHTMLParser() : ImageSearchHTMLParser()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
        {
            let result = parser.parseData(data)
            dispatch_async(dispatch_get_main_queue())
            {
                completion(result)
            }
        }
    }
}
