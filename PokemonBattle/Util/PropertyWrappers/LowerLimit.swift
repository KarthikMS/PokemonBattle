//
//  LowerLimit.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

@propertyWrapper
struct LowerLimit<T: Comparable> {
    let lowerLimit: T
    private var value: T?
    
    init(_ lowerLimit: T) {
        self.lowerLimit = lowerLimit
    }
    
    var wrappedValue: T {
        get { value ?? lowerLimit }
        set { value = max(newValue, lowerLimit) }
    }
}
