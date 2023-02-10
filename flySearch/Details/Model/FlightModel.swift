//
//  DetailsModel.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 18/10/22.
//

import Foundation


struct FlightsResponses: Decodable {
    var termsOfUse: String?
    var currency: String?
    var currPrecision: Int?
    var routeGroup: String?
    var tripType: String?
    var upgradeType: String?
    var trips: [Trips] = []
    var serverTimeUTC: String?
    
    enum CodingKeys: String, CodingKey {
      case termsOfUse
      case currency
      case currPrecision
      case routeGroup
      case tripType
      case upgradeType
      case trips
      case serverTimeUTC
    }
}

struct Trips: Decodable {
    var origin: String?
    var originName: String?
    var destination: String?
    var destinationName: String?
    var routeGroup: String?
    var tripType: String?
    var upgradeType: String?
    var dates: [Dates]? = []
    
    enum CodingKeys: String, CodingKey {
      case origin
      case originName
      case destination
      case destinationName
      case routeGroup
      case tripType
      case upgradeType
      case dates
    }
}

struct Dates: Decodable {
    var dateOut: String?
    var flights: [Flights]? = []
    
    enum CodingKeys: String, CodingKey {
      case dateOut
      case flights
    }
}

struct Flights: Decodable {
    var faresLeft: Int?
    var flightKey: String?
    var infantsLeft: Int?
    var regularFare: RegularFare?
    var operatedBy: String?
    var segments: [Segments] = []
    var flightNumber: String?
    var time: [String]?
    var timeUTC: [String]?
    var duration: String?
    
    enum CodingKeys: String, CodingKey {
      case faresLeft
      case flightKey
      case infantsLeft
      case regularFare
      case operatedBy
      case segments
      case flightNumber
      case time
      case timeUTC
      case duration
    }
}

struct RegularFare: Decodable {
    var fareKey: String?
    var fareClass: String?
    var fares: [Fares]? = []
    
    enum CodingKeys: String, CodingKey {
      case fareKey
      case fareClass
      case fares
    }
}

struct Fares: Decodable {
    var type: String?
    var amount: Double?
    var count: Int?
    var hasDiscount: Bool?
    var publishedFare: Float?
    var discountInPercent: Int?
    var hasPromoDiscount: Bool?
    var discountAmount: Double?
    var hasBogof: Bool?
    
    enum CodingKeys: String, CodingKey {
      case type
      case amount
      case count
      case hasDiscount
      case publishedFare
      case discountInPercent
      case hasPromoDiscount
      case discountAmount
      case hasBogof
    }
}


struct Segments: Decodable {
    var segmentNr: Int?
    var origin: String?
    var destination: String?
    var flightNumber: String?
    var time: [String]?
    var timeUTC: [String]?
    var duration: String?
    
    enum CodingKeys: String, CodingKey {
      case segmentNr
      case origin
      case destination
      case flightNumber
      case time
      case timeUTC
      case duration
    }
}
