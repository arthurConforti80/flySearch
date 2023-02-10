//
//  DetailsViewControllers.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 18/10/22.
//

import Foundation
import UIKit

class FlightDetailViewController: UIViewController {
    
    var viewModel : FlightDetailViewModel!
    
    private lazy var nameTravel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var componentsTravel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let adults = 0
    private let teens = 1
    private let childrens = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationItem.title = "Flights Search"
        setupLabels()
        setupTableView()
        view.addSubview(nameTravel)
        view.addSubview(componentsTravel)
        view.addSubview(tableView)
        viewModel.fetchListFlights()
        setupBindable()
        setupConstraints()
    }
    
    func setupBindable() {
        self.viewModel.updateListSections.bind { [weak self] updateListSections in
            guard let self = self else { return }
            self.nameTravel.text = "\(self.viewModel.reponseListFlights?.trips.first?.origin ?? "") -> \(self.viewModel.reponseListFlights?.trips.first?.destinationName ?? "")"
            self.componentsTravel.text = "\(self.viewModel.itemFlight?.listPassenger[self.adults] ?? 0) Adults, \(self.viewModel.itemFlight?.listPassenger[self.teens] ?? 0) Teens, \(self.viewModel.itemFlight?.listPassenger[self.childrens] ?? 0) Childrens"
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
        tableView.backgroundColor = .systemGray6
        tableView.register(TravelDetailTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    
    func setupConstraints() {
        
        nameTravel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        nameTravel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        nameTravel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        
        componentsTravel.topAnchor.constraint(equalTo: nameTravel.bottomAnchor, constant: 5).isActive = true
        componentsTravel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        componentsTravel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        
        tableView.topAnchor.constraint(equalTo: componentsTravel.bottomAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

    }
    
    func setupLabels() {
        nameTravel.text = "Loading..."
        nameTravel.textAlignment = .left
        nameTravel.textColor = UIColor.black
        nameTravel.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        
        componentsTravel.text = ""
        componentsTravel.textAlignment = .left
        componentsTravel.textColor = UIColor.black
        componentsTravel.font = UIFont.systemFont(ofSize: 12.0)
    }
}

extension FlightDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.itemDates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemDates[section].flights?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TravelDetailTableViewCell
        
        cell?.flights = viewModel.itemDates[indexPath.section].flights?[indexPath.row]
        cell?.departureAirport = viewModel.reponseListFlights?.trips.first?.origin ?? ""
        cell?.arrivalAirport = viewModel.reponseListFlights?.trips.first?.destinationName ?? ""
        cell?.startItemCell()
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let sectionHeaderLabelView = UIView()
        
        let string = viewModel.itemDates[section].dateOut ?? ""
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = formatter4.date(from: string)
        let dateFormated = date?.getFormattedDate(format: "EEEE, MMM d, yyyy")

        let sectionHeaderImage = UIImage(named: "icon_airplane")
        let sectionHeaderImageView = UIImageView(image: sectionHeaderImage)
        sectionHeaderImageView.frame = CGRect(x: 3, y: -25, width: 60, height: 60)
        sectionHeaderLabelView.addSubview(sectionHeaderImageView)
   
        let sectionHeaderLabel = UILabel()
        sectionHeaderLabel.textColor = .black
        sectionHeaderLabel.text = dateFormated
        sectionHeaderLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        sectionHeaderLabel.frame = CGRect(x: 60, y: -17, width: 250, height: 40)
        
        sectionHeaderLabelView.backgroundColor = .systemGray6
        
        sectionHeaderLabelView.addSubview(sectionHeaderLabel)

        return sectionHeaderLabelView

    }
}

extension Date {

   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
