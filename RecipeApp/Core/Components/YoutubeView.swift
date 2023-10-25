//
//  YoutubeView.swift
//  RecipeApp
//
//  Created by Shreya Singh on 10/25/23.
//

import SwiftUI
import WebKit

struct YouTubeView: View {
    let videoURL: URL

    var body: some View {
        WebView(url: videoURL)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

