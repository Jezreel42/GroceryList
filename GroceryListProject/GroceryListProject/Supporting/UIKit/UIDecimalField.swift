//
//  UIDecimalField.swift
//  GroceryListProject
//
//  Created by Jezreel Barbosa on 16/03/20.
//  Copyright © 2020 JezreelBarbosa. All rights reserved.
//

import UIKit

open class UIDecimalField: UITextField {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    final var decimal: Decimal {
        return decimalFromString / pow(10, numberFormatter.maximumFractionDigits)
    }
    
    final var maximum: Decimal = 999_999_999.999999
    
    final var numberFormatter = NumberFormatter() {
        didSet {
            sendActions(for: .editingChanged)
        }
    }
    
    var isPlaceholderShownWhenValueIsZero: Bool = true {
        didSet {
            sendActions(for: .editingChanged)
        }
    }
    
    // Public Methods
    
    @objc func editingChanged() {
        guard decimal <= maximumFraction else {
            text = lastValue
            return
        }
        if isPlaceholderShownWhenValueIsZero && decimal == 0 {
            text = nil
            placeholder = stringFromDecimal
        }
        else {
            text = stringFromDecimal
            lastValue = text
        }
    }
    
    // Initialisation/Lifecycle Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    // Override Methods
    
    open override func deleteBackward() {
        let last = digits.dropLast()
        text = String(last)
        sendActions(for: .editingChanged)
    }
    
    // Private Types
    // Private Properties
    
    private var string: String {
        return text ?? ""
    }
    private var lastValue: String?
    
    private var stringFromDecimal: String {
        return numberFormatter.string(for: decimal) ?? ""
    }
    private var decimalFromString: Decimal {
        return Decimal(string: digits) ?? 0
    }
    private var digits: String {
        return string.filter({ $0.isWholeNumber })
    }
    private var maximumFraction: Decimal {
        return maximum / pow(10, numberFormatter.maximumFractionDigits)
    }
    
    // Private Methods
    
    private func initView() {
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = .current
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
}