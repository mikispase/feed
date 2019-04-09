//
//  DatabaseMapper.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/9/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation

func mapFeedsObject(feeds: Array<Feeds>) -> Array<FeedRealm> {
    
    var result = Array<FeedRealm>()
    
    for test in feeds {
        // Do something you want
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
        result.append(myFeeed)
    }
    
    return result
}
