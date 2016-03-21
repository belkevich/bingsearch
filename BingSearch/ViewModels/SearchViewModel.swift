//
//  SearchViewModel.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import Foundation

class SearchViewModel
{
    private var webItems: [SearchResult]! = nil
    private var imageItmes: [SearchResult]! = nil
    private var updateBlock: ((ErrorType?) -> ())! = nil
    private var searchTimer = SearchTimer()
    private var searchEngine = SearchEngine()

    var searchType: SearchType = .Web

    /// init

    init()
    {
        searchTimer.searchFireBlock()
        { [unowned self] (string: String) in
            self.searchEngine.runQuery(string, completion: self.updateWithWebItems)
        }
    }

    /// mark: public

    func viewModelUpdateBlock(anUpdateBlock: (ErrorType?) -> ())
    {
        updateBlock = anUpdateBlock
    }

    /// mark: properties

    var searchString: String
    {
        get
        {
            return searchTimer.requestString
        }
        set(newSearchString)
        {
            searchTimer.searchRequestString(newSearchString)
        }
    }

    var tableItems: [SearchResult]?
    {
        switch searchType
        {
            case .Web: return webItems
            case .Image: return imageItmes
        }
    }

    /// mark: private

    func updateWithWebItems(webItems aWebItems: [SearchResult]?,
                            imageItems anImageItems: [SearchResult]?,
                            error: ErrorType?)
    {
        webItems = aWebItems
        imageItmes = anImageItems
        updateBlock(error)
    }
}
