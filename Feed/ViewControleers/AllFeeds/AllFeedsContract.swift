//
//  AllFeedsContract.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

protocol AllFeedsView {
    func showAllFeed(feeds : Results<FeedRealm>)
    func showFilteredFeeds(feeds : Results<FeedRealm>)
    func showError(error : Error)
    func showActiviryIndicator(bool: Bool)
}

protocol AllFeedPresenter {
    func getAllFeeds(forceGet : Bool)
    func getFilteredFeeds(searchText: String)
    func bindView(view : AllFeedsView)
    func unbind()
}
