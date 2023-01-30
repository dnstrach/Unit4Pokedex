//
//  ViewController.swift
//  Pokedex
//
//  Created by Dominique Strachan on 1/10/23.
//

import UIKit

class PokemonViewController: UIViewController  {
    
    //MARK: Outlets
    
    @IBOutlet weak var pokeSearchBarV2: UISearchBar!
    
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBarV2.delegate = self
        PokemonController.fetchPokemon(searchterm: "1") { result in
            switch result {
            case .success(let pokemonFromTheWeb):
                print(pokemonFromTheWeb.name)
                self.fetchSpriteAndUpdateViews(pokemon: pokemonFromTheWeb)
            case .failure(let error):
                print(error)
            }
        }
        pokeSearchBarV2.text = ""
    }
    
    //MARK: Methods
    func fetchSpriteAndUpdateViews(pokemon: Pokemon) {
        PokemonController.fetchSprite(pokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let sprite):
                    
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name
                    self.pokeIDLabel.text = String(pokemon.id)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
    
    extension PokemonViewController: UISearchBarDelegate {
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            // Pull text off the search bar
            guard let searchTerm = searchBar.text,
                !searchTerm.isEmpty else { return }
        
            PokemonController.fetchPokemon(searchterm: searchTerm) { [weak self] (result) in
                
                // Return to main thread after a fetch
                DispatchQueue.main.async {
                    
                    // Handle both possible "results"
                    switch result {
                        
                        // If success, get the pokemon's sprite
                    case .success(let pokemon):
//                        self?.fetchSpriteAndUpdateViews(for: pokemon)
                        self?.fetchSpriteAndUpdateViews(pokemon: pokemon)
                        
                        // If failure, notify the user
                    case .failure(let error):
                        self?.presentErrorToUser(localizedError: error)
                    }
                }
            }
        }
    }

    
    /*
    func searchBarButtonClicked(_ searchBar: UISearchBar) {
        
//        guard let searchterm = pokeSearchBarV2.text,
//              !searchterm.isEmpty else { return }
        
        PokemonController.fetchPokemon(searchterm: searchBar.text ?? "nil") { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(pokemon: pokemon)
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
}

*/
