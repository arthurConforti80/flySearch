//
//  TableViewCell.swift
//  flySearch
//
//  Created by Arthur Borges Conforti on 07/02/23.
//

import UIKit

class TravelDetailTableViewCell: UITableViewCell {
    
    
    private lazy var viewItem: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nameItem: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startTime: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var finishTime: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var time: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewSeparator: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var departure: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var arrival: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var price: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var numberFlights: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var flights: Flights?
    var departureAirport = ""
    var arrivalAirport = ""
    
    func startItemCell() {
        self.backgroundColor = .systemGray6
        setupView()
        setupLabels()
        self.addSubview(viewItem)
        viewItem.addSubview(nameItem)
        viewItem.addSubview(startTime)
        viewItem.addSubview(finishTime)
        viewItem.addSubview(numberFlights)
        viewItem.addSubview(viewSeparator)
        viewItem.addSubview(time)
        viewItem.addSubview(departure)
        viewItem.addSubview(arrival)
        viewItem.addSubview(price)
        setupConstraints()
        
    }
    
    func setupView() {
        viewItem.backgroundColor = .white
        viewItem.layer.cornerRadius = 8
        
        viewSeparator.backgroundColor = UIColor.lightGray
    }
    
    func setupLabels() {
        nameItem.text = flights?.operatedBy ?? "Ryanair"
        nameItem.textColor = UIColor.black
        nameItem.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        
        startTime.text = convertTime(text: flights?.time?.first ?? "")
        startTime.textColor = UIColor.black
        startTime.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        
        finishTime.text = convertTime(text: flights?.time?.last ?? "")
        finishTime.textColor = UIColor.black
        finishTime.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        
        numberFlights.text = flights?.flightNumber
        numberFlights.textColor = UIColor.black
        numberFlights.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        numberFlights.textAlignment = .center
        
        time.text = flights?.duration
        time.textColor = UIColor.lightGray
        time.backgroundColor = .white
        time.textAlignment = .center
        time.font = UIFont.systemFont(ofSize: 10.0)
        
        departure.text = "Departure: Airport \(departureAirport ?? "")"
        departure.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        departure.textColor = UIColor.gray
        
        arrival.text = "Arrival: Airport \(arrivalAirport ?? "")"
        arrival.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        arrival.textColor = UIColor.gray
        
        var amount: Double = 0.0
        for getAmount in flights?.regularFare?.fares ?? [] {
            amount = (getAmount.amount ?? 0) + amount
        }
        
        price.text = "Price: \(amount)€"
        price.textColor = UIColor.systemBlue
        price.textAlignment = .right
        price.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        
    }
    
    func setupConstraints() {
        viewItem.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        viewItem.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        viewItem.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        viewItem.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        
        nameItem.topAnchor.constraint(equalTo: viewItem.topAnchor, constant: 10).isActive = true
        nameItem.trailingAnchor.constraint(equalTo: viewItem.trailingAnchor, constant: -10).isActive = true
        nameItem.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10).isActive = true
        
        startTime.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 10).isActive = true
        startTime.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10).isActive = true
        
        finishTime.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 10).isActive = true
        finishTime.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 150).isActive = true
        
        numberFlights.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 10).isActive = true
        numberFlights.trailingAnchor.constraint(equalTo: viewItem.trailingAnchor, constant: -40).isActive = true
        
        viewSeparator.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 20).isActive = true
        viewSeparator.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 10).isActive = true
        viewSeparator.trailingAnchor.constraint(equalTo: finishTime.leadingAnchor, constant: -10).isActive = true
        viewSeparator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        time.topAnchor.constraint(equalTo: nameItem.bottomAnchor, constant: 15).isActive = true
        time.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 52).isActive = true
        time.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        departure.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 10).isActive = true
        departure.trailingAnchor.constraint(equalTo: viewItem.trailingAnchor, constant: -10).isActive = true
        departure.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10).isActive = true
        
        arrival.topAnchor.constraint(equalTo: departure.bottomAnchor, constant: 10).isActive = true
        arrival.trailingAnchor.constraint(equalTo: viewItem.trailingAnchor, constant: -10).isActive = true
        arrival.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10).isActive = true
        
        price.bottomAnchor.constraint(equalTo: viewItem.bottomAnchor, constant: -10).isActive = true
        price.trailingAnchor.constraint(equalTo: viewItem.trailingAnchor, constant: -10).isActive = true
        price.leadingAnchor.constraint(equalTo: viewItem.leadingAnchor, constant: 10).isActive = true
        
    }
    
    func convertTime(text: String) -> String {
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = formatter4.date(from: text)
        let dateFormated = date?.getFormattedDate(format: "HH:mm") ?? ""
        return dateFormated
    }

}
