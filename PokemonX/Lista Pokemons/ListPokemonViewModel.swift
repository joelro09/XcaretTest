//
//  ListPokemonViewModel.swift
//  PokemonX
//
//  Created by Joel Ramirez on 09/03/23.
//

import Foundation

class ListPokemonViewModel {
    
    var pokemons: Observable<[Pokemon]> =  Observable([])
    
    func getPokemons() {
    
        guard let url = URL(string: Constants.listPokemonsPath) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let pokemonList = try JSONDecoder().decode(Pokemons.self, from: data)
                let pokemons = pokemonList.results
                
                for pokemon in pokemons {
                    print("Name: \(String(describing: pokemon.name))")
                    print("Image URL: \(pokemon.imageURL)")
                }
                
                self.pokemons.value.append(contentsOf: pokemons)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
}
