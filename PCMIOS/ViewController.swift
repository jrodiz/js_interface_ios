//
//  ViewController.swift
//  PCMIOS
//
//  Created by Joseph Rodiz Cuevas on 9/9/19.
//  Copyright © 2019 Joseph Rodiz Cuevas. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    // https://medium.com/capital-one-tech/javascript-manipulation-on-ios-using-webkit-2b1115e7e405
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /* Test of postmessage */
        //let scriptSource = "window.webkit.messageHandlers.totDevicePCM.postMessage(`Hi`);"
        // Instantiate a WKUserScript object and specify when you’d like to inject your script
        // and whether it’s for all frames or the main frame only.
        //let userScript = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let webViewPref = WKPreferences()
        webViewPref.javaScriptEnabled = true
        webViewPref.javaScriptCanOpenWindowsAutomatically = true
        
        let userContentController = WKUserContentController()
        //userContentController.addUserScript(userScript) //Uncoment for testing
        userContentController.add(self, name: "totDevicePCM")
        
        let config = WKWebViewConfiguration()
        config.preferences = webViewPref
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        
        view.addSubview(webView)
        let layoutGuide = view.safeAreaLayoutGuide
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        
        if let url = URL(string: "URL HERE WHICH ATTENDS totDevicePCM INTERFACE") {
            webView.load(URLRequest(url: url))
        }
    }
    
}

//MARK: - Javasript handler

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "totDevicePCM", let messageBody = message.body as? String {
            print(messageBody)
        }
    }
}


