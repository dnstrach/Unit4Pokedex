//
//  PokemonError.swift
//  Pokedex
//
//  Created by Dominique Strachan on 1/10/23.
//

import Foundation

enum PokemonError: LocalizedError {
    //what developers see
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    //what user sees
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach PokeAPI.co"
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
