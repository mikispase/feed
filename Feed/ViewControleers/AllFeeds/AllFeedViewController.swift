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

class AllFeedViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UpdateFeed, AllFeedsView,UISearchResultsUpdating{
    
    @IBOutlet var tableView: UITableView!
    
    var feeds: Results<FeedRealm>?
    
    var filteredFeed: Results<FeedRealm>?
    
    var presenter: AllFeedPresenter?
    
    var resultSearchController = UISearchController()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("ReloadData"), object: nil)
        
        initPresenter()
        
        presenter?.bindView(view: self)
        presenter?.getAllFeeds(forceGet: true)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 125
        
        self.resultSearchController = ({
            return createSearchController()
        })()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(getRefreshDataFromServer(_:)), for: .valueChanged)

        
    }
    
    func initPresenter() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        presenter = AllFeedPresenterImp(feedRepo: delegate.feedRepo!)
    }
    
    
    fileprivate func createSearchController() -> UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.dimsBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        controller.searchBar.barTintColor = .white
        controller.searchBar.backgroundColor = .clear
        self.tableView.tableHeaderView = controller.searchBar
        return controller
    }
    
    @objc private func getRefreshDataFromServer(_ sender: Any) {
        presenter?.getAllFeeds(forceGet: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return filteredFeed!.count
        }else{
            return feeds?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedCell
        if self.resultSearchController.isActive {
            cell.populateDataForCell(feeds: filteredFeed![indexPath.row], indexPath: indexPath as NSIndexPath)
        } else {
            cell.populateDataForCell(feeds: feeds![indexPath.row], indexPath: indexPath as NSIndexPath)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FeedDetailsViewController") as! FeedDetailsViewController
        vc.feedRealm =  self.resultSearchController.isActive ? (filteredFeed?[indexPath.row])! :   feeds![indexPath.row]
        vc.delegate = self
        resultSearchController.isActive = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("updateSearchResults")
        presenter?.getFilteredFeeds(searchText: searchController.searchBar.text!)
    }
    
    func showFilteredFeeds(feeds: Results<FeedRealm>) {
        filteredFeed = feeds
        updateFeedReloadData()
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
        if self.refreshControl.isRefreshing == false {
            bool ? ProgressHUD.show() : ProgressHUD.dismiss()
        }
        else {
            bool ?  self.refreshControl.beginRefreshing() : self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(with:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(with:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(with notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        var contentInset = self.tableView.contentInset
        contentInset.bottom += keyboardFrame.height
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
    
    @objc func keyboardWillHide(with notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        var contentInset = self.tableView.contentInset
        contentInset.bottom -= keyboardFrame.height
        tableView.contentInset = contentInset
        tableView.scrollIndicatorInsets = contentInset
    }
}





