//
//  ViewController.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet var favoriteFeedContentView: UIView!
    
    @IBOutlet var allFeedContentView: UIView!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Feeds"
        favoriteFeedContentView.alpha = 0
        allFeedContentView.alpha = 1
        
    }
    @IBAction func segmentControlPressed(_ sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0) {
            title = "Feeds"
            
            self.allFeedContentView.alpha = 1
            self.favoriteFeedContentView.alpha = 0
        }
        else {
            title = "Favorite Feeds"
            
            self.allFeedContentView.alpha = 0
            self.favoriteFeedContentView.alpha = 1
        }
        
    }
}



