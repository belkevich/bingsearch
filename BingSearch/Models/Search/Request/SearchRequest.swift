//
//  SearchRequest.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

typealias SearchCompletion = ([SearchResult]?, [SearchResult]?, ErrorType?) -> ()

struct SearchRequest
{
    let query: String
    let type: SearchType
    let completion: SearchCompletion
}
