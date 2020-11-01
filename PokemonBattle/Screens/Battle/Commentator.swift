//
//  Commentator.swift
//  PokemonBattle
//
//  Created by Karthik on 01/11/20.
//

import Combine

protocol Commentator {
    var commentStream: AnyPublisher<String, Never> { get }
    func comment(_ message: String)
}

final class TextCommentator: Commentator {
    private let commentSubject = PassthroughSubject<String, Never>()
}

// MARK: - Commentator
extension TextCommentator {
    var commentStream: AnyPublisher<String, Never> { commentSubject.eraseToAnyPublisher() }
    
    func comment(_ message: String) {
        commentSubject.send(message)
    }
}
