//
//  HomeModel.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import Foundation

struct StationsResponse: Decodable {
    var stations: [Stations]
    
    enum CodingKeys: String, CodingKey {
      case stations
    }
}

struct Stations: Decodable {
    var code: String?
    var name: String?
    var alternateName: String? = ""
    var alias: [String]
    var countryCode: String?
    var countryName: String?
    var countryAlias: String? = ""
    var countryGroupCode: String?
    var countryGroupName: String?
    var timeZoneCode: String?
    var latitude: String?
    var longitude: String?
    var mobileBoardingPass: Bool?
    var markets: [Markets] = []
    var notices: String? = ""
    var tripCardImageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case alternateName
        case alias
        case countryCode
        case countryName
        case countryAlias
        case countryGroupCode
        case countryGroupName
        case timeZoneCode
        case latitude
        case longitude
        case mobileBoardingPass
        case markets
        case notices
        case tripCardImageUrl
    }
}


struct Markets: Decodable {
    var code: String?
    var group: String?
    var stops: [Stops]? = []
    var onlyConnecting: Bool?
    
    enum CodingKeys: String, CodingKey {
        case code
        case group
        case stops
        case onlyConnecting
    }
}

struct Stops: Decodable {
    var code: String?
    
    enum CodingKeys: String, CodingKey {
        case code
    }
}

struct ItemFlight: Encodable {
    var listPassenger: [Int]
    var dateDeparture: String
    var dateArrival: String
    var codeDeparture: String
    var codeArrival: String
    
    enum CodingKeys: String, CodingKey {
        case listPassenger
        case dateDeparture
        case dateArrival
        case codeDeparture
        case codeArrival
    }
}
