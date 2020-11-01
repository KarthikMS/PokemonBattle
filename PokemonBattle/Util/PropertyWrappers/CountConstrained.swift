//
//  CountConstrained.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

@propertyWrapper
struct CountConstrained<T> {
    private var value = [T]()
    let maxCount: Int
    
    init(maxCount: Int) {
        self.maxCount = maxCount
    }
    
    var wrappedValue: [T] {
        get { value }
        set {
            value = newValue
            
            while newValue.count > maxCount {
                value.removeLast()
            }
        }
    }
}
