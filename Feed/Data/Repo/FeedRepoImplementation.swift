//
//  FeedRepoImplementation.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class FeedRepoImplementation: FeedRepo {
    
    var mockupFeedSerice : FeedService
    var networkeedSerice : FeedService
    var databaseFeedSerice : FeedService

    init(mockupFeedService: FeedService ,networkeedSerice: FeedService, databaseFeedSerice: FeedService) {
        self.mockupFeedSerice = mockupFeedService
        self.databaseFeedSerice = databaseFeedSerice
        self.networkeedSerice = networkeedSerice
    }

    func getFeeds(onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        networkeedSerice.getAllFeeds(onComplete: { (result) in
            let feeds = result as! Array<Feeds>
            self.databaseFeedSerice.saveFeeds(feeds: feeds, onComplete: onComplete, onError: onError)

        }, onError: { (error) in
            self.databaseFeedSerice.getAllFeeds(onComplete: onComplete, onError: onError)
        })
    }
}
