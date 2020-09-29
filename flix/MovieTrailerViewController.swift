//
//  MovieTrailerViewController.swift
//  flix
//
//  Created by Joseph Fontana on 9/28/20.
//  Copyright © 2020 Joseph Fontana. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
        
    var apiLink = ""
    
    var movieData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: apiLink)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           }
           else if let data = data {
            
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                self.movieData = dataDictionary["results"] as! [[String:Any]]
                
                let movieResult = self.movieData[0]
                               
                let youtubeKey = movieResult["key"] as! String
                               
                print(youtubeKey)
                
                let myURL = URL(string:"https://www.youtube.com/watch?v=\(youtubeKey)")
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
            
               
           }
        }
        
        
        task.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
