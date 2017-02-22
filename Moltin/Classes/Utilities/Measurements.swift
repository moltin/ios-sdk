//
//  Measurements.swift
//  Pods
//
//  Created by Oliver Foggin on 22/02/2017.
//
//

import Foundation

protocol MTUnitConverter {
    func value(fromBaseUnitValue baseValue: Double) -> Double
    func baseValue(fromValue value: Double) -> Double
}

public class MTUnit {
    let symbol: String
    
    var unitConverter: MTUnitConverter! {
        get {
            return nil
        }
    }
    
    init(symbol: String) {
        self.symbol = symbol
    }
}

public class MTUnitLength: MTUnit, MTUnitConverter {
    let coefficient: Double
    
    override var unitConverter: MTUnitConverter {
        get {
            return self
        }
    }
    
    init(symbol: String, coefficient: Double) {
        self.coefficient = coefficient
        
        super.init(symbol: symbol)
    }
    
    class var meters: MTUnitLength {
        get {
            return MTUnitLength(symbol: "m", coefficient: 1)
        }
    }
    
    class var centimeters: MTUnitLength {
        get {
            return MTUnitLength(symbol: "cm", coefficient: 0.01)
        }
    }
    
    class var inches: MTUnitLength {
        get {
            return MTUnitLength(symbol: "in", coefficient: 0.0254)
        }
    }
    
    class var feet: MTUnitLength {
        get {
            return MTUnitLength(symbol: "ft", coefficient: 0.3048)
        }
    }
    
    class var yards: MTUnitLength {
        get {
            return MTUnitLength(symbol: "yd", coefficient: 0.9144)
        }
    }
    
    class var miles: MTUnitLength {
        get {
            return MTUnitLength(symbol: "mi", coefficient: 1609.34)
        }
    }
    
    func value(fromBaseUnitValue baseValue: Double) -> Double {
        return baseValue / coefficient
    }
    
    func baseValue(fromValue value: Double) -> Double {
        return value * coefficient
    }
}

public class MTUnitMass: MTUnit, MTUnitConverter {
    let coefficient: Double
    
    override var unitConverter: MTUnitConverter! {
        get {
            return self
        }
    }
    
    init(symbol: String, coefficient: Double) {
        self.coefficient = coefficient
        
        super.init(symbol: symbol)
    }
    
    class var pounds: MTUnitMass {
        get {
            return MTUnitMass(symbol: "lbs", coefficient: 0.453592)
        }
    }
    
    class var kilograms: MTUnitMass {
        get {
            return MTUnitMass(symbol: "kg", coefficient: 1)
        }
    }
    
    class var grams: MTUnitMass {
        get {
            return MTUnitMass(symbol: "g", coefficient: 0.001)
        }
    }
    
    class var ounces: MTUnitMass {
        get {
            return MTUnitMass(symbol: "oz", coefficient: 0.0283495)
        }
    }
    
    func value(fromBaseUnitValue baseValue: Double) -> Double {
        return baseValue / coefficient
    }
    
    func baseValue(fromValue value: Double) -> Double {
        return value * coefficient
    }
}

public struct MTMeasurement<T: MTUnit> {
    let value: Double
    let unit: T
    
    func converting(to conversionUnit: T) -> MTMeasurement<T> {
        let baseValue = unit.unitConverter.baseValue(fromValue: value)
        let convertedValue = conversionUnit.unitConverter.value(fromBaseUnitValue: baseValue)
        
        return MTMeasurement(value: convertedValue, unit: conversionUnit)
    }
}

extension MTMeasurement: CustomStringConvertible {
    public var description: String {
        get {
            let numberFormatter: NumberFormatter = {
                let nf = NumberFormatter()
                nf.positiveFormat = "#.0"
                return nf
            }()
            
            if let valueString = numberFormatter.string(from: NSNumber(value: value)) {
                return "\(valueString)\(unit.symbol)"
            }
            
            return "\(value)\(unit.symbol)"
        }
    }
}
