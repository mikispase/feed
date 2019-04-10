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
import MapKit
import CoreLocation

protocol UpdateFeed {
    func updateFeedReloadData()
}

class FeedDetailsViewController: UIViewController , UITextFieldDelegate {
    
    var delegate:UpdateFeed?
    
    @IBOutlet var tableView: UITableView!
    
    let locationManager = CLLocationManager()

    @IBOutlet var headerView: UIView!
    
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
    
    @IBOutlet var colectionView: UICollectionView!
    
    @IBOutlet var mapView: MKMapView!
    
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
        
        colectionView.delegate = self
        colectionView.dataSource = self
        
        let restaurantLocation = CLLocationCoordinate2D(latitude: (feedRealm.venueLat! as NSString).doubleValue, longitude:(feedRealm.vanueLong! as NSString).doubleValue)
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta:0.05)
        let region = MKCoordinateRegion(center: restaurantLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = restaurantLocation
        annotation.title =  feedRealm.venueStreet
        annotation.subtitle = feedRealm.venueName
        mapView.addAnnotation(annotation)
        
        tableView.tableHeaderView = headerView
        
        colectionView.reloadData()
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
                label5.text = textField.text
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
        label2.text = feedRealm.artistID
        label5.text = feedRealm.venueName
        label7.text = feedRealm.venueCountry
        label8.text = feedRealm.artistName
    }
}

// MARK: - UICollectionViewDataSource
extension FeedDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self).filter("artistName == %@", feedRealm.artistName!)
        return results.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self).filter("artistName == %@", feedRealm.artistName!)
        let feed = results[indexPath.row]
        
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ColectionCell", for: indexPath) as! ArtistCollectionViewCell
        cell.imageViewArtist.sd_setImage(with: URL(string: feed.venueImageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        cell.nameArtist.text = feed.eventDate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self).filter("artistName == %@", feedRealm.artistName!)
        feedRealm = results[indexPath.row]
        self.viewDidLoad()
    }
    
}


