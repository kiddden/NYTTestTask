//
//  BuyLinkWebView.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 10.07.2023.
//

//import UIKit
import WebKit
import SwiftUI

struct BuyLinkWebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let url: String
    
    let webView: WKWebView
    
    init(url: String) {
        self.url = url
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
