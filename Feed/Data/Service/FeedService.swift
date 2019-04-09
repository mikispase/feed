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
    func getAllFeeds() -> Results<FeedRealm>
    func getAllFeedsNetwork(onComplete: @escaping Completition, onError: @escaping ErrorComplete) 
}
