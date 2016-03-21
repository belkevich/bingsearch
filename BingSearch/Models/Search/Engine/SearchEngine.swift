//
//  SearchEngine.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

class SearchEngine
{
    private let network = NetworkClient()
    private let parser = AsyncParser()
    private var webItems: [SearchResult]? = nil
    private var imageItems: [SearchResult]? = nil
    private var webLoaded = false
    private var imageLoaded = false
    private var currentQuery: String! = nil

    /// mark: public

    func runQuery(query: String, completion: SearchCompletion)
    {
        webLoaded = false
        imageLoaded = false
        currentQuery = query
        let webRequest = SearchRequest(query: query, type: .Web, completion: completion)
        let imageRequest = SearchRequest(query: query, type: .Image, completion: completion)
        let webCompletion = self.networkCompletionWithRequest(webRequest)
        let imageCompletion = self.networkCompletionWithRequest(imageRequest)
        network.loadRequest(query, type: .Web, completion: webCompletion)
        network.loadRequest(query, type: .Image, completion: imageCompletion)
    }

    /// mark: private

    func networkCompletionWithRequest(request: SearchRequest) -> NetworkCompletion
    {
        let completion =
        { [unowned self] (data: NSData?, error: ErrorType?) in
            if data != nil && request.query == self.currentQuery
            {
                let parserCompletion = self.parserCompletionWithRequest(request)
                self.parser.parseData(data!, type: request.type, completion: parserCompletion)
            }
            else if let networkError = error
            {
                request.completion(nil, nil, networkError)
            }
        }
        return completion
    }

    func parserCompletionWithRequest(request: SearchRequest) -> ParserCompletion
    {
        let completion =
        { [unowned self] (resultItems: [SearchResult]?) in
            if request.query == self.currentQuery
            {
                switch request.type
                {
                    case .Web:
                        self.webLoaded = true
                        self.webItems = resultItems

                    case .Image:
                        self.imageLoaded = true
                        self.imageItems = resultItems
                }
                if self.webLoaded && self.imageLoaded
                {
                    request.completion(self.webItems, self.imageItems, nil)
                }
            }
        }
        return completion
    }
}
