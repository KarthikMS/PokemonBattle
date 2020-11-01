//
//  MaxCount.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

@propertyWrapper
struct MaxCount<T> {
    private var value = [T]()
    let maxCount: Int
    
    init(_ maxCount: Int) {
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
