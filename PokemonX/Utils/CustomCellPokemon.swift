//
//  CustomCellPokemon.swift
//  PokemonX
//
//  Created by Joel Ramirez on 08/03/23.
//

import UIKit


class CustomCellPokemon: UICollectionViewCell {
    
    
    private let stackMovies: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderColor = UIColor.black.cgColor
        stack.spacing = 10
        
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
    
    private let imagePokemon: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let namePokemon: UILabel = {
       let labelM = UILabel()
        labelM.font = .systemFont(ofSize: 16)
        labelM.textAlignment = .center
        labelM.numberOfLines = 2
        labelM.translatesAutoresizingMaskIntoConstraints = false
        
        return labelM
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        /*
        layer.cornerRadius = 10
        layer.masksToBounds = true
        */
        addSubview(stackMovies)
        stackMovies.addArrangedSubview(imagePokemon)
        stackMovies.addArrangedSubview(namePokemon)
        
        imagePokemon.layer.cornerRadius = 20
        imagePokemon.layer.masksToBounds = true
        configureConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([stackMovies.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     stackMovies.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     stackMovies.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor)
                                    ])
        
        
    }
    
    var pokemonList: Pokemon? {
        didSet{
        
            namePokemon.text = pokemonList?.name
            imagePokemon.downloaded(from: pokemonList?.imageURL)
          //  imagePokemon.downloaded(from: Constants.pathImage(path:moviesList?.imageURL ?? "dum URL"))
            
            
        }
    }
    
    func configure(model: PruebaPok) {
        imagePokemon.image = UIImage(named: model.image)
        namePokemon.text = model.name
      }
}

