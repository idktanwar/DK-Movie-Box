//
//  EmbedYouTubeVideoViewController.swift
//  Samples
//
//  Created by VikasK on 07/02/19.
//  Copyright © 2019 Vikaskore Software. All rights reserved.
//

import UIKit
import WebKit
import AVKit

class EmbedYouTubeVideoViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet var webView: WKWebView!
    var url: String?
    var youTubeID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else {
            return
        }
        
        //Get video ID
        do {
            let regex = try NSRegularExpression(pattern: "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)", options: .caseInsensitive)
            let match = regex.firstMatch(in: url, options: .reportProgress, range: NSMakeRange(0, url.lengthOfBytes(using: String.Encoding.utf8)))
            let range = match?.range(at: 0)
            youTubeID = (url as NSString).substring(with: range!)
        } catch {
            print(error)
        }
        
        loadYoutube(videoID: youTubeID)
        
    }
    
    //MARK:- Play Video
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
}
