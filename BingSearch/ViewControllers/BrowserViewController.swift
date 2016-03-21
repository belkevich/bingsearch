//
//  BrowserViewController.swift
//  BingSearch
//
//  Created by Alexey Belkevich on 20.03.16.
//  Copyright © 2016 Alexey Belkevich. All rights reserved.
//

import UIKit

class BrowserViewController: UIViewController
{
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private var url: NSURL?

    /// mark: appearance

    override func viewDidLoad()
    {
        super.viewDidLoad()
        updateWebView()
    }

    /// mark: properties

    var link: String
    {
        get
        {
            return url?.absoluteString ?? ""
        }
        set(newLink)
        {
            url = NSURL(string: newLink)
            updateWebView()
        }
    }

    /// mark: private

    private func updateWebView()
    {
        if let anURL = url, let aWebView = webView
        {
            let request = NSURLRequest(URL: anURL)
            aWebView.loadRequest(request)
        }
    }
}

extension BrowserViewController: UIWebViewDelegate
{
    func webViewDidStartLoad(webView: UIWebView)
    {
        activityView.startAnimating()
    }

    func webViewDidFinishLoad(webView: UIWebView)
    {
        activityView.stopAnimating()
    }

    func webView(webView: UIWebView, didFailLoadWithError error: NSError?)
    {
        activityView.stopAnimating()
    }
}