//
//  NetworkClient.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (NSData?, ErrorType?) -> ()

class NetworkClient
{
    private let bingWebQuery = "http://www.bing.com/search?q="
    private let bingImageQuery = "http://www.bing.com/images/search?q="

    /// mark: public

    func loadRequest(request: String, type: SearchType, completion: NetworkCompletion)
    {
        let prefix = type == .Web ? bingWebQuery : bingImageQuery
        if let url = NSURL(string: prefix + request)
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
            {
                var data: NSData?
                var dataError: ErrorType?
                do
                {
                    data = try NSData(contentsOfURL: url, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    data?.writeToFile("/Users/alex/Desktop/1.html", atomically: true)
                    print("success")
                }
                catch
                {
                    dataError = error
                }

                dispatch_async(dispatch_get_main_queue())
                {
                    completion(data, dataError)
                }
            }
        }
    }
}