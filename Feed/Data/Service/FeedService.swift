//
//  FeedService.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

protocol FeedService {
    func getAllFeeds(onComplete: @escaping Completition, onError: @escaping ErrorComplete)
    
    func saveFeeds(feeds : Array<Feeds>, onComplete: @escaping Completition, onError: @escaping ErrorComplete)
    
    func getFilteredFeeds(searchText : String, onComplete: @escaping Completition)
    
}
