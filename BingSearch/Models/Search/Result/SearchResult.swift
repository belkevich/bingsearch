//
//  SearchResult.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import UIKit

class SearchResult
{
    let title: String
    let subtitle: String
    let link: String
    let image: String?

    init(title aTitle: String, subtitle aSubtitle: String, link aLink: String, image anImage: String?)
    {
        title = aTitle
        subtitle = aSubtitle
        link = aLink
        image = anImage
    }
}
