//
//  FeedNetworkService.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class FeedNetworkService : FeedService {
   
    func getAllFeeds(onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        serverClientBaseAny(_url: SERVERBASEURL, params: nil, httpMethid: .get, onComplete: { (result) in
            var feeds = Array<Feeds>()
            let arr = result as! Array<Dictionary<String, String>>
            for item in arr {
                let item1 = item as Dictionary<String, String>
                let feed = Feeds(object: item1)
                feeds.append(feed)
            }
            
            onComplete(feeds)
        }) { (error : Error) in
            onError(error)
        }
    }
    
    func saveFeeds(feeds: Array<Feeds>, onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
    }
    
}
