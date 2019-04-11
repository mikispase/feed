//
//  FeedRepo.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

typealias Completition = (_ result: Any) -> Void
typealias ErrorComplete = (_ result: Error) -> Void

import Foundation

protocol FeedRepo {
    func getFeeds(onComplete:@escaping Completition, onError:@escaping ErrorComplete)
    
    func getFilteredFeeds(searchText: String, onComplete: @escaping Completition)
}
