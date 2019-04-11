//
//  FeedDataBaseService.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

class FeedDataBaseService: FeedService {
 
    func getAllFeeds(onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self)
        onComplete(results)
    }
    
    func saveFeeds(feeds: Array<Feeds>, onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        
        let realm = try! Realm()
        let realmFeeds = mapFeedsObject(feeds: feeds)
        for feed in realmFeeds {
            try! realm.write {
                let results = realm.objects(FeedRealm.self).filter("eventId == %@",feed.eventId!)
                if (results.count == 0)
                {
                    realm.add(feed)
                }
            }
        }
        
        let results = realm.objects(FeedRealm.self)
        onComplete(results)
    }
    
    func getFilteredFeeds(searchText: String, onComplete: @escaping Completition) {
        let realm = try! Realm()
        let searchString = searchText
        let results = realm.objects(FeedRealm.self).filter("venueName CONTAINS[c]'\(searchString)' OR eventDate CONTAINS[c]'\(searchString)' OR artistName CONTAINS[c]'\(searchString)'")
        onComplete(results)
    }
    
}
