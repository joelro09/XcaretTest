//
//  DetailPokemonViewModel.swift
//  PokemonX
//
//  Created by Joel Ramirez on 10/03/23.
//

import Foundation

class DetailPokemonViewModel {
   
    var pokemon = Observable(DetailPokemon())
    
    func getPokemon(idPokemon: Int){
        
        // Obtener el detalle de cada pokemon
        guard let detailURL = URL(string: Constants.detailPathPok(id: idPokemon)) else { return }
                            
                            let detailTask = URLSession.shared.dataTask(with: detailURL) { (data, response, error) in
                                print("URL: \(detailURL)")
                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }
                                
                                guard let data = data else { return }
                                
                                do {
                                    let pokemonDetail = try JSONDecoder().decode(DetailPokemon.self, from: data)
                                    
                                    self.pokemon.value = pokemonDetail
                                    
                                    
                                } catch let error {
                                    print(error.localizedDescription)
                                }
                            }
                            
                            detailTask.resume()
    }
    
}

