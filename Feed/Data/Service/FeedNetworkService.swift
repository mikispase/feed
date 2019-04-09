//
//  FeedNetworkService.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

class FeedNetworkService : FeedService {
   
    func getAllFeeds() -> Results<FeedRealm> {
        let realm = try! Realm()
        let results = realm.objects(FeedRealm.self)
        return results
    }
    
    func getAllFeedsNetwork(onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        ServerInvoker_allFeeds(onComplete: onComplete, onError: onError)
    }
}
