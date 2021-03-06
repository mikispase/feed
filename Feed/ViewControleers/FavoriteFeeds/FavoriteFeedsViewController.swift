//
//  FavoriteFeedsViewController.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import RealmSwift

protocol NeedsRefreshTableView {
    func needsRefreshTableView()
}

class FavoriteFeedsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UpdateFeed {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("ReloadData"), object: nil)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = filterMyFavoriteFeed()
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        let results = filterMyFavoriteFeed()
        cell.populateDataForCell(feeds: results[indexPath.row] as FeedRealm, indexPath: indexPath as NSIndexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        let results = filterMyFavoriteFeed()
        vc.feedRealm = results[indexPath.row]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let realm = try! Realm()
            try! realm.write {
                let results = filterMyFavoriteFeed()
                let feedRealm = results[indexPath.row]
                feedRealm.isMyFavorite = "false"
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    func updateFeedReloadData() {
        tableView.reloadData()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        tableView.reloadData()
    }
    
    func filterMyFavoriteFeed() -> Results<FeedRealm>{
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self).filter("isMyFavorite == 'true'")
        return results
    }
    
}
