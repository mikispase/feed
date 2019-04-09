//
//  AllFeedPresenter.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

class AllFeedPresenterImp : AllFeedPresenter {
    
    var view: AllFeedsView?
    
    var feedRepo:FeedRepo
    
    
    init(feedRepo:FeedRepo) {
        self.feedRepo = feedRepo
    }
    
    func getAllFeeds(forceGet: Bool) {
        self.view?.showActiviryIndicator(bool: true)
        
        feedRepo.getFeeds(onComplete: { (feed: Any) in
            self.view?.showActiviryIndicator(bool: false)
            self.view?.showAllFeed(feeds: feed as! Results<FeedRealm>)
        }, onError: { (error: Error) in
            self.view?.showActiviryIndicator(bool: false)
            self.view?.showError(error: error)
        })
    }
    
    func bindView(view: AllFeedsView) {
        self.view = view
    }
    
    func unbind() {
        self.view = nil
    }
    
    
}
