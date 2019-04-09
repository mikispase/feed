//
//  FeedRealm.swift
//  Feed
//
//  Created by Dimitar Spasovski on 4/8/19.
//  Copyright © 2019 Dimitar Spasovski. All rights reserved.
//

import Foundation
import RealmSwift

class FeedRealm : Object {
     @objc dynamic var stock: String?
     @objc dynamic var artistID: String?
     @objc dynamic var eventTime: String?
     @objc dynamic var venueLat: String?
     @objc dynamic var vanueLong: String?
     @objc dynamic var eventDate: String?
     @objc dynamic var venueZipcode: String?
     @objc dynamic var venueName: String?
     @objc dynamic var artistTourName: String?
     @objc dynamic var artistImage: String?
     @objc dynamic var venuebuildingNumber: String?
     @objc dynamic var eventId: String?
     @objc dynamic var venueCountry: String?
     @objc dynamic var venueCity: String?
     @objc dynamic var artistName: String?
     @objc dynamic var artiestPopularity: String?
     @objc dynamic var venueImageUrl: String?
     @objc dynamic var venueID: String?
     @objc dynamic var venueStreet: String?
     @objc dynamic var isMyFavorite: String?
     @objc var image: Data? = nil //optional
}
