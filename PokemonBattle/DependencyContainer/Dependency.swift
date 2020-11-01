//
//  Dependency.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Swinject

@propertyWrapper
public class Dependency<T> {
    public let wrappedValue: T
    
    public init(container: Container = dependencyContainer) {
        wrappedValue = container.resolve(T.self)!
    }
}
