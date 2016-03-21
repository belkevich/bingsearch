//
//  SearchViewController.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 19.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import UIKit
import DTTableViewManager
import DTModelStorage
import EKKeyboardAvoiding

class SearchViewController: UIViewController, DTTableViewManageable
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet var searchField: SearchFieldView!

    private let viewModel = SearchViewModel()

    // mark: appearance

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.searchField.delegate = self
        tableView.setKeyboardAvoidingEnabled(true)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        manager.startManagingWithDelegate(self)
        manager.registerCellClass(SearchTableCell)
        manager.cellSelection(SearchViewController.selectedItem)
        viewModel.viewModelUpdateBlock()
        { [unowned self] (error: ErrorType?) in
            self.showProgress(false)
            self.updateTableItems()
            self.showError(error)
        }
    }

    // mark: actions

    @IBAction func segmentValueChanged(segmentedControl: UISegmentedControl)
    {
        switch segmentedControl.selectedSegmentIndex
        {
            case 0: viewModel.searchType = .Web
            default: viewModel.searchType = .Image
        }
        updateTableItems()
    }

    // mark: segue

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        super.prepareForSegue(segue, sender: sender)
        if let controller = segue.destinationViewController as? BrowserViewController,
        let castedSender = sender, let item = castedSender as? SearchResult
        {
            controller.title = item.title
            controller.link = item.link
        }
    }

    // mark: private

    private func selectedItem(cell: SearchTableCell, item: SearchResult, indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier(String(BrowserViewController), sender: item)
    }

    private func updateTableItems()
    {
        manager.memoryStorage.removeAllItems()
        let validItems = viewModel.tableItems != nil && viewModel.tableItems!.count > 0
        tableView.hidden = !validItems
        noResultsLabel.hidden = validItems
        if validItems
        {
            manager.memoryStorage.addItems(viewModel.tableItems!)
        }
        else
        {
            noResultsLabel.text = "No Results"
        }
    }

    private func showProgress(show: Bool)
    {
        show ? activityView.startAnimating() : activityView.stopAnimating()
    }

    private func showError(error: ErrorType?)
    {

    }
}

extension SearchViewController: SearchFieldDelegate
{
    func searchField(searchField: SearchFieldView, changeText text: String?)
    {
        showProgress(true)
        viewModel.searchString = text ?? ""
    }
}

