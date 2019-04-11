//
//  FeedMockupService.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/9/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class FeedMockupService: FeedService {
 
    func getAllFeeds(onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
        let realm = try! Realm()
        
        let location = "json"
        let fileType = "json"
        if let path = Bundle.main.path(forResource: location, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try! JSON(data: data)
                if jsonObj != JSON.null {
                    
                    print(jsonObj.count)
                    
                    for (key,subJson):(String, JSON) in jsonObj {
                        // Do something you want
                        
                        let test = Feeds(object: subJson)
                        let myFeeed = FeedRealm()
                        
                        myFeeed.stock = test.stock
                        myFeeed.artistID = test.artistID
                        myFeeed.eventTime = test.eventTime
                        myFeeed.venueLat = test.venueLat
                        myFeeed.vanueLong = test.vanueLong
                        myFeeed.eventDate = test.eventDate
                        myFeeed.venueZipcode = test.venueZipcode
                        myFeeed.venueName = test.venueName
                        myFeeed.artistTourName = test.artistTourName
                        myFeeed.artistImage = test.artistImage
                        myFeeed.venuebuildingNumber = test.venuebuildingNumber
                        myFeeed.eventId = test.eventId
                        myFeeed.venueCountry = test.venueCountry
                        myFeeed.venueCity   = test.venueCity
                        myFeeed.artistName = test.artistName
                        myFeeed.artiestPopularity = test.artiestPopularity
                        myFeeed.venueImageUrl = test.venueImageUrl
                        myFeeed.venueID = test.venueID
                        myFeeed.venueStreet = test.venueStreet
                        
                        try! realm.write {
                            let results = realm.objects(FeedRealm.self).filter("eventId == %@",test.eventId!)
                            if (results.count == 0)
                            {
                                realm.add(myFeeed)
                            }
                        }
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }}
        
        let results = realm.objects(FeedRealm.self)
        onComplete(results)
    }
    
    func saveFeeds(feeds: Array<Feeds>, onComplete: @escaping Completition, onError: @escaping ErrorComplete) {
    }

    func getFilteredFeeds(searchText: String, onComplete: @escaping Completition) {
        
    }
    
    
}
