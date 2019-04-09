//
//  Feeds.swift
//
//  Created by Dimitar Spasovski on 4/8/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Feeds: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let stock = "Stock"
    static let artistID = "ArtistID"
    static let eventTime = "EventTime"
    static let venueLat = "VenueLat"
    static let vanueLong = "VanueLong"
    static let eventDate = "EventDate"
    static let venueZipcode = "VenueZipcode"
    static let venueName = "VenueName"
    static let artistTourName = "ArtistTourName"
    static let artistImage = "ArtistImage"
    static let venuebuildingNumber = "VenuebuildingNumber"
    static let eventId = "EventId"
    static let venueCountry = "VenueCountry"
    static let venueCity = "VenueCity"
    static let artistName = "ArtistName"
    static let artiestPopularity = "ArtiestPopularity"
    static let venueImageUrl = "VenueImageUrl"
    static let venueID = "VenueID"
    static let venueStreet = "VenueStreet"
  }

  // MARK: Properties
  public var stock: String?
  public var artistID: String?
  public var eventTime: String?
  public var venueLat: String?
  public var vanueLong: String?
  public var eventDate: String?
  public var venueZipcode: String?
  public var venueName: String?
  public var artistTourName: String?
  public var artistImage: String?
  public var venuebuildingNumber: String?
  public var eventId: String?
  public var venueCountry: String?
  public var venueCity: String?
  public var artistName: String?
  public var artiestPopularity: String?
  public var venueImageUrl: String?
  public var venueID: String?
  public var venueStreet: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    stock = json[SerializationKeys.stock].string
    artistID = json[SerializationKeys.artistID].string
    eventTime = json[SerializationKeys.eventTime].string
    venueLat = json[SerializationKeys.venueLat].string
    vanueLong = json[SerializationKeys.vanueLong].string
    eventDate = json[SerializationKeys.eventDate].string
    venueZipcode = json[SerializationKeys.venueZipcode].string
    venueName = json[SerializationKeys.venueName].string
    artistTourName = json[SerializationKeys.artistTourName].string
    artistImage = json[SerializationKeys.artistImage].string
    venuebuildingNumber = json[SerializationKeys.venuebuildingNumber].string
    eventId = json[SerializationKeys.eventId].string
    venueCountry = json[SerializationKeys.venueCountry].string
    venueCity = json[SerializationKeys.venueCity].string
    artistName = json[SerializationKeys.artistName].string
    artiestPopularity = json[SerializationKeys.artiestPopularity].string
    venueImageUrl = json[SerializationKeys.venueImageUrl].string
    venueID = json[SerializationKeys.venueID].string
    venueStreet = json[SerializationKeys.venueStreet].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = stock { dictionary[SerializationKeys.stock] = value }
    if let value = artistID { dictionary[SerializationKeys.artistID] = value }
    if let value = eventTime { dictionary[SerializationKeys.eventTime] = value }
    if let value = venueLat { dictionary[SerializationKeys.venueLat] = value }
    if let value = vanueLong { dictionary[SerializationKeys.vanueLong] = value }
    if let value = eventDate { dictionary[SerializationKeys.eventDate] = value }
    if let value = venueZipcode { dictionary[SerializationKeys.venueZipcode] = value }
    if let value = venueName { dictionary[SerializationKeys.venueName] = value }
    if let value = artistTourName { dictionary[SerializationKeys.artistTourName] = value }
    if let value = artistImage { dictionary[SerializationKeys.artistImage] = value }
    if let value = venuebuildingNumber { dictionary[SerializationKeys.venuebuildingNumber] = value }
    if let value = eventId { dictionary[SerializationKeys.eventId] = value }
    if let value = venueCountry { dictionary[SerializationKeys.venueCountry] = value }
    if let value = venueCity { dictionary[SerializationKeys.venueCity] = value }
    if let value = artistName { dictionary[SerializationKeys.artistName] = value }
    if let value = artiestPopularity { dictionary[SerializationKeys.artiestPopularity] = value }
    if let value = venueImageUrl { dictionary[SerializationKeys.venueImageUrl] = value }
    if let value = venueID { dictionary[SerializationKeys.venueID] = value }
    if let value = venueStreet { dictionary[SerializationKeys.venueStreet] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.stock = aDecoder.decodeObject(forKey: SerializationKeys.stock) as? String
    self.artistID = aDecoder.decodeObject(forKey: SerializationKeys.artistID) as? String
    self.eventTime = aDecoder.decodeObject(forKey: SerializationKeys.eventTime) as? String
    self.venueLat = aDecoder.decodeObject(forKey: SerializationKeys.venueLat) as? String
    self.vanueLong = aDecoder.decodeObject(forKey: SerializationKeys.vanueLong) as? String
    self.eventDate = aDecoder.decodeObject(forKey: SerializationKeys.eventDate) as? String
    self.venueZipcode = aDecoder.decodeObject(forKey: SerializationKeys.venueZipcode) as? String
    self.venueName = aDecoder.decodeObject(forKey: SerializationKeys.venueName) as? String
    self.artistTourName = aDecoder.decodeObject(forKey: SerializationKeys.artistTourName) as? String
    self.artistImage = aDecoder.decodeObject(forKey: SerializationKeys.artistImage) as? String
    self.venuebuildingNumber = aDecoder.decodeObject(forKey: SerializationKeys.venuebuildingNumber) as? String
    self.eventId = aDecoder.decodeObject(forKey: SerializationKeys.eventId) as? String
    self.venueCountry = aDecoder.decodeObject(forKey: SerializationKeys.venueCountry) as? String
    self.venueCity = aDecoder.decodeObject(forKey: SerializationKeys.venueCity) as? String
    self.artistName = aDecoder.decodeObject(forKey: SerializationKeys.artistName) as? String
    self.artiestPopularity = aDecoder.decodeObject(forKey: SerializationKeys.artiestPopularity) as? String
    self.venueImageUrl = aDecoder.decodeObject(forKey: SerializationKeys.venueImageUrl) as? String
    self.venueID = aDecoder.decodeObject(forKey: SerializationKeys.venueID) as? String
    self.venueStreet = aDecoder.decodeObject(forKey: SerializationKeys.venueStreet) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(stock, forKey: SerializationKeys.stock)
    aCoder.encode(artistID, forKey: SerializationKeys.artistID)
    aCoder.encode(eventTime, forKey: SerializationKeys.eventTime)
    aCoder.encode(venueLat, forKey: SerializationKeys.venueLat)
    aCoder.encode(vanueLong, forKey: SerializationKeys.vanueLong)
    aCoder.encode(eventDate, forKey: SerializationKeys.eventDate)
    aCoder.encode(venueZipcode, forKey: SerializationKeys.venueZipcode)
    aCoder.encode(venueName, forKey: SerializationKeys.venueName)
    aCoder.encode(artistTourName, forKey: SerializationKeys.artistTourName)
    aCoder.encode(artistImage, forKey: SerializationKeys.artistImage)
    aCoder.encode(venuebuildingNumber, forKey: SerializationKeys.venuebuildingNumber)
    aCoder.encode(eventId, forKey: SerializationKeys.eventId)
    aCoder.encode(venueCountry, forKey: SerializationKeys.venueCountry)
    aCoder.encode(venueCity, forKey: SerializationKeys.venueCity)
    aCoder.encode(artistName, forKey: SerializationKeys.artistName)
    aCoder.encode(artiestPopularity, forKey: SerializationKeys.artiestPopularity)
    aCoder.encode(venueImageUrl, forKey: SerializationKeys.venueImageUrl)
    aCoder.encode(venueID, forKey: SerializationKeys.venueID)
    aCoder.encode(venueStreet, forKey: SerializationKeys.venueStreet)
  }

}
