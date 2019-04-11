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
    
    var feedRealm = FeedRealm()
    
    let annotation = MKPointAnnotation()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: UIView!
    @IBOutlet var colectionView: UICollectionView!
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var feedImage: UIImageView!
    @IBOutlet var feedName: UITextField!
    @IBOutlet var artistImageView: UIImageView!
    @IBOutlet var lblArtistName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblLocation: UILabel!
    
    lazy var favoriteBarButton: UIBarButtonItem = {
        UIBarButtonItem.init(image: UIImage(named: "big"),
                             style: .plain,
                             target: self,
                             action: #selector(action))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        feedName.delegate = self
        
        navigationItem.rightBarButtonItem = favoriteBarButton
        
        changeBarButtonImage()
        
        colectionView.delegate = self
        colectionView.dataSource = self
        
        tableView.tableHeaderView = headerView
        
        setupView()
        
    }
    
    
    func setupView() {
        
        // Setup Location
        let restaurantLocation = CLLocationCoordinate2D(latitude: (feedRealm.venueLat! as NSString).doubleValue, longitude:(feedRealm.vanueLong! as NSString).doubleValue)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta:0.05)
        let region = MKCoordinateRegion(center: restaurantLocation, span: span)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = restaurantLocation
        annotation.title =  feedRealm.venueStreet
        annotation.subtitle = feedRealm.venueName
        mapView.addAnnotation(annotation)
        
        title = "Feed Details"
        
        labels()
        
        feedImage.sd_setImage(with: URL(string: feedRealm.venueImageUrl!), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        artistImageView.sd_setImage(with: URL(string: feedRealm.artistImage!), placeholderImage: UIImage(named: "placeholder.png"))
        
        artistImageView.layer.borderWidth = 1.0
        artistImageView.layer.masksToBounds = false
        artistImageView.layer.borderColor = UIColor.white.cgColor
        artistImageView.layer.cornerRadius = artistImageView.frame.size.width / 2
        artistImageView.clipsToBounds = true
        
        feedName.text = feedRealm.venueName
        
        colectionView.reloadData()
        
        debugPrint(feedRealm)
        
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
                //  label5.text = textField.text
                annotation.subtitle = textField.text
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
        lblArtistName.text = feedRealm.artistName
        lblDate.text = feedRealm.eventDate! + " " + feedRealm.eventTime! + "h"
        lblLocation.text = feedRealm.venueCountry! + " , " + feedRealm.venueCity! + " , " + feedRealm.venueStreet!
        
    }
    
    @IBAction func presentFullMap(_ sender: UIButton) {
        let vcMapView = storyboard?.instantiateViewController(withIdentifier: "MapViewViewController") as! MapViewViewController
        vcMapView.feedRealm = feedRealm
        let navigationController = UINavigationController(rootViewController: vcMapView)
        present(navigationController, animated: true, completion: nil)
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
        cell.venueName.text = feed.venueName
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self).filter("artistName == %@", feedRealm.artistName!)
        feedRealm = results[indexPath.row]
        setupView()
        scrollToFirstRow()
    }
    
    
    func scrollToFirstRow() {
        self.tableView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
     
}


