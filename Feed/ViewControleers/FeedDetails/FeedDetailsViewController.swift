//
//  FeedDetailsViewController.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage




protocol UpdateFeed {
    func updateFeedReloadData()
}

class FeedDetailsViewController: UIViewController , UITextFieldDelegate {
    
    var delegate:UpdateFeed?
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    @IBOutlet var label10: UILabel!
    
    
    lazy var favoriteBarButton: UIBarButtonItem = {
        UIBarButtonItem.init(image: UIImage(named: "big"),
                             style: .plain,
                             target: self,
                             action: #selector(action))
    }()
    
    @IBOutlet var feedImage: UIImageView!
    
    @IBOutlet var feedName: UITextField!
    
    var feedRealm = FeedRealm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print(feedRealm)
        self.hideKeyboardWhenTappedAround()
        
        feedName.delegate = self
        
        feedName.text = feedRealm.venueName
        
        navigationItem.rightBarButtonItem = favoriteBarButton
        
        changeBarButtonImage()
        
        feedImage.sd_setImage(with: URL(string: feedRealm.venueImageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        
        labels()
        
    }
    
    func changeBarButtonImage(){
        favoriteBarButton.image = UIImage(named: (feedRealm.isMyFavorite == "true") ? "selected" : "not-selected" )!.withRenderingMode(.alwaysOriginal)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != feedRealm.venueName {
            let realm = try! Realm()
            try! realm.write {
                feedRealm.venueName = textField.text
                delegate?.updateFeedReloadData()
                addObserverForReloadData()                
            }
        }
    }
    
    @objc func action() {
        let realm = try! Realm()
        
        try! realm.write {
            if (feedRealm.isMyFavorite == nil || feedRealm.isMyFavorite == "false"){
                feedRealm.isMyFavorite = "true"
            }
            else {
                feedRealm.isMyFavorite = "false"
            }
            changeBarButtonImage()
            delegate?.updateFeedReloadData()
            addObserverForReloadData()
        }
    }
    
    func addObserverForReloadData(){
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil, userInfo: nil)
    }
    
    func labels(){
        label1.text = feedRealm.stock
        label2.text = feedRealm.artistID
        label3.text = feedRealm.eventTime
        label4.text = feedRealm.eventDate
        label5.text = feedRealm.venueName
        label6.text = feedRealm.artistTourName
        label7.text = feedRealm.venueCountry
        label8.text = feedRealm.artistName
        label9.text = feedRealm.venueStreet
        label10.text = feedRealm.eventId
    }
}



