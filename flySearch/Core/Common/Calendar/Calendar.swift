//
//  File.swift
//  flySearch
//
//  Created by Arthur Borges Conforti on 10/02/23.
//

import Foundation
import UIKit

public protocol CalendarViewDelegate: AnyObject {
    func dateSelected(text: String, textFields: UITextField)
}

class CalendarView: UIView {
    
    
    weak var delegate: CalendarViewDelegate!
    var calendarView = UICalendarView()
    var textfields: UITextField?
    
    func startCalendar(view: UIView, textFieldsReceived: UITextField) {
        textfields = textFieldsReceived
        calendarView.isHidden = false
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendarView.calendar = gregorianCalendar
        calendarView.fontDesign = .rounded
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
           calendarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
           calendarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
           calendarView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
        calendarView.backgroundColor = .secondarySystemBackground
        calendarView.layer.cornerCurve = .continuous
        calendarView.layer.cornerRadius = 10.0
        calendarView.tintColor = UIColor.systemTeal
        calendarView.availableDateRange = DateInterval.init(start: Date.now, end: Date.distantFuture)
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
    }
}

extension CalendarView: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        let font = UIFont.systemFont(ofSize: 10)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "star.fill", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
        return .image(image)
    }
}

extension CalendarView: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        let date = "\(dateComponents.year ?? 0)-\(dateComponents.month ?? 0)-\(dateComponents.day ?? 0)"
        delegate.dateSelected(text: date, textFields: textfields ?? UITextField())
        calendarView.isHidden = true
    }
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {}
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
}
