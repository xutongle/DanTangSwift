//
//  RFTMALLViewController.swift
//  DanTangSwift
//
//  Created by rocky on 16/8/22.
//  Copyright © 2016年 RockyFung. All rights reserved.
//

import UIKit

class RFTMALLViewController: RFBaseViewController {

    
    var product: RFProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        
        let webView = UIWebView()
        webView.frame = CGRectMake(0, 0, SCREENW, SCREENH)
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        view.addSubview(webView)
        let url = NSURL(string: product!.purchase_url!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }

    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(navigationBackClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: #selector(shareBBItemClick))
    }
    
    func shareBBItemClick() {
    }
    
    func navigationBackClick() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension RFTMALLViewController: UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}


















