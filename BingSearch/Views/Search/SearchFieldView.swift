//
//  SearchFieldView.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import UIKit

protocol SearchFieldDelegate: class
{
    func searchField(searchField: SearchFieldView, changeText text: String?)
}

class SearchFieldView: UIView
{
    @IBOutlet weak var searchField: UITextField!

    weak var delegate: SearchFieldDelegate?
}

extension SearchFieldView: UITextFieldDelegate
{
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange,
                   replacementString string: String) -> Bool
    {
        let previousString = textField.text as NSString?
        let searchString = previousString?.stringByReplacingCharactersInRange(range, withString: string)
        delegate?.searchField(self, changeText: searchString)
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
