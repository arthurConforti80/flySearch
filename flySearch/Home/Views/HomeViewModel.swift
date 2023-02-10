//
//  HomeViewModel.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 16/10/22.
//


import Foundation
import Alamofire

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func didTapFlightDetail(search: ItemFlight?)
}

protocol HomeViewModelProtocol {
    var coordinatorDelegate : HomeViewModelCoordinatorDelegate?{get set}
    var reponseListStations: StationsResponse?{get set}
    var reponseListFlights: FlightsResponses?{get set}
    var updateListSections: Bindable<Bool> { get set }
    var listPassenger: [Int] { get set }
    var titlePassenger: String { get set }
    func goToFlight(departure: String, arrivel: String, codeDeparture: String, codeArrival: String)
}

class HomeViewModel: HomeViewModelProtocol {
    
    weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    var reponseListStations: StationsResponse?
    var reponseListFlights: FlightsResponses?
    var updateListSections: Bindable<Bool> = Bindable(false)
    var itemStations: [Stations] = []
    var listCompouse: [String] = []
    var listPassenger: [Int] = [1,0,0]
    var titlePassenger = "1 Adults"

    func goToFlight(departure: String, arrivel: String, codeDeparture: String, codeArrival: String) {
        
        
        
        let searchSelected: ItemFlight = .init(listPassenger: listPassenger,
                                               dateDeparture: departure,
                                               dateArrival: arrivel,
                                               codeDeparture: splitString(text: codeDeparture),
                                               codeArrival: splitString(text: codeArrival))
        
        self.coordinatorDelegate?.didTapFlightDetail(search: searchSelected)
    }
   
    func fetchListStations() {
        let StationJson = "https://mobile-testassets-dev.s3.eu-west-1.amazonaws.com/stations.json"
        let request = AF.request(StationJson)
        request.responseDecodable(of: StationsResponse.self) { (response) in
          guard let flights = response.value else { return }
          self.reponseListStations = flights
            for stations in self.reponseListStations?.stations ?? [] {
                self.itemStations.append(stations)
          }
          self.updateListSections.value = true
        }
    }
    
    func getListCompouse() -> [String] {
        var str: String
        for item in itemStations {
            str = "\(item.code ?? ""), \(item.name ?? "")"
            listCompouse.append(str)
        }
        return listCompouse
    }
    
    func splitString(text: String) -> String {
        let code = text.components(separatedBy: ",")
        return code.first ?? ""
    }
}

