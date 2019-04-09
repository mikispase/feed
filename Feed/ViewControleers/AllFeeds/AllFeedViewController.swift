//
//  AllFeedViewController.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON
import ProgressHUD

class AllFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate , UpdateFeed, AllFeedsView{
 
    @IBOutlet var tableView: UITableView!

    var feeds: Results<FeedRealm>?
    var presenter: AllFeedPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("ReloadData"), object: nil)

        initPresenter()
        
        presenter?.bindView(view: self)
        presenter?.getAllFeeds(forceGet: true)
    }

    func initPresenter() {
        let networkService = FeedNetworkService()
        let mockService = FeedMockupService()
        let databaseService = FeedDataBaseService()
        
        let weatherRepo = FeedRepoImplementation(mockupFeedService: mockService, networkeedSerice: networkService, databaseFeedSerice: databaseService)
        presenter = AllFeedPresenterImp(feedRepo: weatherRepo)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        cell.populateDataForCell(feeds: feeds![indexPath.row], indexPath: indexPath as NSIndexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        vc.feedRealm = feeds![indexPath.row]
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateFeedReloadData() {
       self.tableView.reloadData()
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
       updateFeedReloadData()
    }
    
    func showAllFeed(feeds: Results<FeedRealm>) {
        self.feeds = feeds
        updateFeedReloadData()
    }
    
    func showError(error: Error) {
        showAlertMessage(message: error.localizedDescription)
    }
    
    func showActiviryIndicator(bool: Bool) {
        bool ? ProgressHUD.show() : ProgressHUD.dismiss()
    }
}


    

