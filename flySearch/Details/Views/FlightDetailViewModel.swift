//
//  DetailsViewModel.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 18/10/22.
//


import Foundation
import Alamofire

protocol FlightDetailViewModelCoordinatorDelegate: AnyObject {}

protocol FlightDetailViewModelProtocol {
    var coordinatorDelegate : HomeViewModelCoordinatorDelegate?{get set}
    var reponseListFlights: FlightsResponses?{get set}
    var updateListSections: Bindable<Bool> { get set }
    var itemFlight: ItemFlight? { get set }
}

class FlightDetailViewModel: FlightDetailViewModelProtocol {

    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    var reponseListFlights: FlightsResponses?
    var updateListSections: Bindable<Bool> = Bindable(false)
    var itemDates: [Dates] = []
    var itemFlight: ItemFlight?

    func fetchListFlights() {
        let headers : HTTPHeaders = ["Content-Type": "application/json", "client": "ios"]
        let urlRequest = "https://nativeapps.ryanair.com/api/v4/en-IE/Availability?origin=\(itemFlight?.codeDeparture ?? "")&destination=\(itemFlight?.codeArrival ?? "")&dateout=\(itemFlight?.dateDeparture ?? "")&datein=\(itemFlight?.dateArrival ?? "")&flexdaysbeforeout=3&flexdaysout=3&flexdaysbeforein=3&flexdaysin=3&adt=\(itemFlight?.listPassenger.first ?? 0)&teen=\(itemFlight?.listPassenger[1] ?? 0)&chd=\(itemFlight?.listPassenger[2] ?? 0)&inf=0&roundtrip=false&ToUs=AGREED&Disc=0"
        let request = AF.request(urlRequest, headers: headers)
         request.responseDecodable(of: FlightsResponses.self) { (response) in
           guard let flights = response.value else { return }
           self.reponseListFlights = flights
             for trips in self.reponseListFlights?.trips.first?.dates ?? [] {
                 if trips.flights?.count ?? 0 > 0 {
                     self.itemDates.append(trips)
                 }
             }
           self.updateListSections.value = true
         }
    }
}




