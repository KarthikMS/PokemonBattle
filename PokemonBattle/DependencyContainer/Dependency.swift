//
//  Dependency.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Swinject

@propertyWrapper
class Dependency<T> {
    let wrappedValue: T
    
    init(container: Container = dependencyContainer, name: String? = nil) {
        if let name = name {
            wrappedValue = container.resolve(T.self, name: name)!
        } else {
            wrappedValue = container.resolve(T.self)!
        }
    }
}
