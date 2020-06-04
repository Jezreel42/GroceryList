//
//  GroceryPresentationModel.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 03/06/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

final class GroceryPresentationModel {
    // Static Properties
    
    static var listTotal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = .current
        numberFormatter.numberStyle = .currency
        
        var totalDecimal: Decimal = 0
        Grocery.list.forEach { (grocery) in
            let factor: Decimal = (grocery.unit == .g100) ? 0.1 : 1
            let subTotal = grocery.price * grocery.quantity / factor
            totalDecimal += subTotal
        }
        return numberFormatter.string(for: totalDecimal) ?? ""
    }
    
    // Static Methods
    // Public Types
    // Public Properties
    
    weak var grocery: Grocery? = nil {
        didSet{
            NotificationCenter.default.removeObserver(self)
            guard grocery != nil else { return }
            NotificationCenter.default.addObserver(self, selector: #selector(updateValues), name: Grocery.valuesDidChangedNN, object: grocery)
            updateValues()
        }
    }
    
    let nameBox: Box<String> = Box("")
    let priceBox: Box<String> = Box("")
    let quantityBox: Box<String> = Box("")
    let totalBox: Box<String> = Box("")
    let unitBox: Box<String> = Box("")
    let unitOfMeasurimentBox: Box<Grocery.UnitOfMeasurement> = Box(.unit)
    
    // Public Methods
    
    @objc func updateValues() {
        nameBox.value = name
        priceBox.value = price
        quantityBox.value = quantity
        totalBox.value = total
        unitBox.value = unit
        unitOfMeasurimentBox.value = unitOfMeasuriment
    }
    
    // Initialisation/Lifecycle Methods
    
    init() {
        numberFormatter.locale = .current
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let numberFormatter = NumberFormatter()
    
    private var name: String {
        return grocery?.name ?? ""
    }
    
    private var price: String {
        guard let grocery = grocery else { return "" }
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(for: grocery.price) ?? ""
    }
    
    private var quantity: String {
        guard let grocery = grocery else { return "" }
        
        switch grocery.unit {
        case .unit:
            numberFormatter.numberStyle = .none
            numberFormatter.maximumFractionDigits = 0
            numberFormatter.minimumFractionDigits = 0
            
        case .kg, .l, .g100:
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 3
            numberFormatter.minimumFractionDigits = 3
        }
        return numberFormatter.string(for: grocery.quantity) ?? ""
    }
    
    private var total: String {
        guard let grocery = grocery else { return "" }
        
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        
        let factor: Decimal = (grocery.unit == .g100) ? 0.1 : 1
        let total = grocery.price * grocery.quantity / factor
        
        return numberFormatter.string(for: total) ?? ""
    }
    
    private var unit: String {
        guard let grocery = grocery else { return "" }
        
        switch grocery.unit {
        case .unit:
            return " un"
            
        case .g100:
            return "Kg / 100g"
            
        case .kg:
            return "Kg"
            
        case .l:
            return "L"
            
        }
    }
    
    private var unitOfMeasuriment: Grocery.UnitOfMeasurement {
        return grocery?.unit ?? .unit
    }
    
    // Private Methods
}