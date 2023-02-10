//
//  HomeViewController.swift
//  FlightSearch
//
//  Created by Arthur Borges Conforti on 16/10/22.
//

import Foundation
import UIKit


class HomeViewController: UIViewController {
    
    var viewModel : HomeViewModel!
    
    private lazy var fromTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var toTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var startTravelTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var finishTravelTextField: UITextField = {
        let view = UITextField(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var adults: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var adultsPicker: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var teensPicker: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var childrensPicker: UIPickerView = {
        let view = UIPickerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) var toolbar: UIToolbar?
    
    var calendarView = CalendarView()
    
    override func viewDidLoad() {
      super.viewDidLoad()
      view.backgroundColor = .white
      navigationItem.title = "Flights Search"
      viewModel.fetchListStations()
      setupBindable()
      setupTextfields()
      setupButtons()
      view.addSubview(fromTextField)
      view.addSubview(toTextField)
      view.addSubview(startTravelTextField)
      view.addSubview(finishTravelTextField)
      view.addSubview(adults)
      view.addSubview(searchButton)
      setupConstraints()
      calendarView.delegate = self
      
    }
    
    func setupBindable() {
        self.viewModel.updateListSections.bind { [weak self] updateListSections in
            guard let self = self else { return }
            self.viewModel.getListCompouse()
            self.toTextField.isEnabled = true
            self.callDropDown(textFields: self.fromTextField)
            self.callDropDown(textFields: self.toTextField)
        }
    }
    
    func setupConstraints() {
        
        fromTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        fromTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        fromTextField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        fromTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        toTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        toTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        toTextField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        toTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        startTravelTextField.topAnchor.constraint(equalTo: self.fromTextField.bottomAnchor, constant: 10).isActive = true
        startTravelTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        startTravelTextField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        startTravelTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        finishTravelTextField.topAnchor.constraint(equalTo: self.toTextField.bottomAnchor, constant: 10).isActive = true
        finishTravelTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        finishTravelTextField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        finishTravelTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        adults.topAnchor.constraint(equalTo: self.finishTravelTextField.bottomAnchor, constant: 0).isActive = true
        adults.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        adults.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        adults.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: self.adults.bottomAnchor, constant: 20).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    
    func setupButtons() {
        searchButton.setTitle("Search", for: .normal)
        searchButton.backgroundColor = UIColor.systemBlue
        searchButton.layer.cornerRadius = 8
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchDown)
        
        adults.setTitle(viewModel.titlePassenger, for: .normal)
        adults.setTitleColor(UIColor.black, for: .normal)
        adults.backgroundColor = .clear
        adults.layer.cornerRadius = 8
        adults.addTarget(self, action: #selector(startPicker), for: .touchDown)

    }
    
    func setupTextfields() {
        
        fromTextField.layer.cornerRadius = 8
        fromTextField.layer.borderColor = UIColor.lightGray.cgColor
        fromTextField.layer.borderWidth = 1
        fromTextField.placeholder = "Departure"
        fromTextField.textAlignment = .center
        
        toTextField.placeholder = "Arrival"
        toTextField.layer.cornerRadius = 8
        toTextField.layer.borderColor = UIColor.lightGray.cgColor
        toTextField.layer.borderWidth = 1
        toTextField.textAlignment = .center
        toTextField.isEnabled = false
        
        startTravelTextField.placeholder = "dom 12 de fev"
        startTravelTextField.layer.cornerRadius = 8
        startTravelTextField.layer.borderColor = UIColor.lightGray.cgColor
        startTravelTextField.layer.borderWidth = 1
        startTravelTextField.textAlignment = .center
        startTravelTextField.addTarget(self, action: #selector(calendar), for: .touchDown)
        
        finishTravelTextField.placeholder = "dom 19 de fev"
        finishTravelTextField.layer.cornerRadius = 8
        finishTravelTextField.layer.borderColor = UIColor.lightGray.cgColor
        finishTravelTextField.layer.borderWidth = 1
        finishTravelTextField.textAlignment = .center
        finishTravelTextField.addTarget(self, action: #selector(calendar), for: .touchDown)

    }
    
    func callDropDown(textFields: UITextField){
        let dropDownTop = VPAutoComplete()
        dropDownTop.dataSource = viewModel.listCompouse
        dropDownTop.onTextField = textFields
        dropDownTop.onView = view
        dropDownTop.showAlwaysOnTop = true
        dropDownTop.show { (str, index) in
            textFields.text = str
        }
    }
    
    func addToolbar() {
        toolbar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 230, width: UIScreen.main.bounds.size.width, height: 50))
        toolbar?.barStyle = .default
        toolbar?.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolbar ?? UIToolbar())
    }
    
    @objc func calendar(_ sender: UITextField) {
        calendarView.startCalendar(view: self.view, textFieldsReceived: sender)
    }
    
    @objc func startPicker(_ sender: UIButton) {
        adultsPicker.delegate = self
        adultsPicker.dataSource = self
        view.addSubview(adultsPicker)
        self.addToolbar()
        adultsPicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        adultsPicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        adultsPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func onDoneButtonTapped() {
        toolbar?.removeFromSuperview()
        adultsPicker.removeFromSuperview()
    }
    
    @objc func searchAction(_ sender: UIButton) {
        viewModel.goToFlight(departure: startTravelTextField.text ?? "", arrivel: finishTravelTextField.text ?? "", codeDeparture: fromTextField.text ?? "", codeArrival: toTextField.text ?? "")
    }
}

extension HomeViewController: CalendarViewDelegate {
    func dateSelected(text: String, textFields: UITextField) {
        textFields.text = text
    }
}

extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var str = ""
        
        switch component {
        case 0:
            str = "Adults \(row)"
        case 1:
            str = "Teens \(row)"
        case 2:
            str = "childrens \(row)"
        default:
            break
        }
        
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.listPassenger[component] = row
        viewModel.titlePassenger = "\(viewModel.listPassenger[0]) Adults, \(viewModel.listPassenger[1]) Teens, \(viewModel.listPassenger[2]) Childrens "
        self.adults.setTitle(viewModel.titlePassenger, for: .normal)
    }
}

