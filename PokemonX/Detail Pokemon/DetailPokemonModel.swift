//
//  DetailPokemonModel.swift
//  PokemonX
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

struct Pokemon: Codable {
   var name: String?
   var url: URL
    
    var imageURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.lastPathComponent).png") ?? URL(string: "")!
        }
    
    init(){
        name = ""
        url = URL(string: "www.google.com")!
    }
}


struct Generation: Codable {
    var name: String
    var url: String
}

struct DetailPokemon: Codable {


    var id: Int
    var name: String
    var base_experience: Int
    var is_main_series: Bool
    var abilities: PokAbilities
    
    init(){
        id = 1
        name = "Default"
        base_experience = 1
        is_main_series = true
        abilities = PokAbilities()
    }
}

struct Effects: Codable {
    var effect: String
    var short_effect: String
    
    init(){
        effect = "Default Effect Description"
        short_effect = "Default short"
    }
}

struct PokAbilities: Codable {
    var is_hidden: Bool
    var slot: Int
    var ability: Pokemon
    
    init(){
        is_hidden = true
        slot = 1
        ability = Pokemon()
    }
}

struct PokemonD: Codable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault: URL
}
