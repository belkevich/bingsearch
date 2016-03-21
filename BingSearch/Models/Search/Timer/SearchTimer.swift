//
//  SearchTimer.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

class SearchTimer
{
    private var request: String = ""
    private var fireBlock: ((String) -> ())! = nil

    /// mark: public

    func searchFireBlock(block: (String) -> ())
    {
        fireBlock = block
    }

    func searchRequestString(string: String)
    {
        request = string
        runSearchRequestWithString(string)
    }

    /// mark: properties

    var requestString: String
    {
        return request
    }

    /// mark: private

    private func runSearchRequestWithString(string: String)
    {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue())
        {
            if self.request == string
            {
                self.fireBlock(self.request)
            }
        }
    }
}
