//
//  DetailPokemonViewController.swift
//  PokemonX
//
//  Created by Joel Ramirez on 07/03/23.
//

import UIKit

class DetailPokemonViewController: UIViewController {
    
    var idPokemon = 1
    
    var nombre = ""
    var imagen = ""
    var url = ""
    
    var pokemon: DetailPokemon?
    let viewModel = DetailPokemonViewModel()
    
    
    private let stackPokemon: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.black.cgColor
        stack.spacing = 6
        
        return stack
    }()
    
    private let stackChild: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.black.cgColor
        stack.spacing = 10
        
        return stack
    }()
    
    private var imagePokemon: CustomImageView = {
        var image = CustomImageView()
        image.image = UIImage(named: "detaildum")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 310).isActive = true
        image.widthAnchor.constraint(equalToConstant: 310).isActive = true
        
        return image
    }()
    
    private let pokebolaImge: CustomImageView = {
        let image = CustomImageView()
        image.image = UIImage(named: "pokebola")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let namePokemon: UILabel = {
       let labelM = UILabel()
        labelM.textAlignment = .center
        labelM.font = .systemFont(ofSize: 20)
        labelM.textColor = .black
        labelM.numberOfLines = 2
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let descriptionPokemon: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.numberOfLines = 5
        labelM.text = "Attacken die Schaden verursachen haben mit jedem Treffer eine 10% Chance das Ziel zurückschrecken zu lassen, wenn die Attacke dies nicht bereits als Nebeneffekt hat.\n\nDer Effekt stapelt nicht mit dem von getragenen Items.\n\nAußerhalb vom Kampf: Wenn ein Pokémon mit dieser Fähigkeit an erster Stelle im Team steht, tauchen wilde Pokémon nur halb so oft auf."
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let hpPokemon: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 26)
        labelM.textColor = .red
        labelM.numberOfLines = 8
        labelM.text = "HP 200"
        labelM.textAlignment = .center
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let powerPokemon: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.text = "Incineración: 90"
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let powerTwo: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 14)
        labelM.text = "Golpe de Calor: 100"
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    private let imageError: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "error")
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Definir el color personalizado en hexadecimal para la barra de navegación
        let customColor = UIColor(hexString: "#0E438E")

       
        // Configurar el color de fondo de la barra de navegación
        self.navigationController?.navigationBar.barTintColor = customColor
       
        // Crear la imagen que se utilizará como título
            let titleImage = UIImage(named: "head")
            let imageView = UIImageView(image: titleImage)
            imageView.contentMode = .scaleAspectFit
            // Establecer la imagen como título en la barra de navegación
            navigationItem.titleView = imageView
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
        
        view.backgroundColor = .white
        [imagePokemon,stackPokemon, namePokemon, imageError].forEach(view.addSubview)
        
        stackPokemon.addArrangedSubview(namePokemon)
        stackPokemon.addArrangedSubview(hpPokemon)
        stackPokemon.addArrangedSubview(pokebolaImge)
        stackPokemon.addArrangedSubview(stackChild)
        stackChild.addArrangedSubview(powerTwo)
        stackChild.addArrangedSubview(powerPokemon)
        stackPokemon.addArrangedSubview(descriptionPokemon)
        
         
        
        imagePokemon.layer.cornerRadius = 20
        imagePokemon.layer.masksToBounds = true
        
        configureConstraints()
        
        namePokemon.text = nombre
        
        if ListPokemonViewController.isConnected == true {
            viewModel.getPokemon(idPokemon: idPokemon)
            
            viewModel.pokemon.bind { [weak self] pokemon in
                self?.pokemon = pokemon
                self?.namePokemon.text = pokemon.name
                self?.hpPokemon.text = "\(pokemon.base_experience)"
                self?.imagePokemon.downloaded(from: pokemon.abilities.ability.imageURL)
                self?.descriptionPokemon.text = pokemon.abilities.ability.name
            }
        }else {
            self.namePokemon.text = nombre
            imagePokemon.image = UIImage(named: imagen)
        }
        
        
    }
    
    
    func configureConstraints() {
        imagePokemon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imagePokemon.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackPokemon.topAnchor.constraint(equalTo: imagePokemon.bottomAnchor, constant: 20).isActive = true
        stackPokemon.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        stackPokemon.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    }
    
 
}
