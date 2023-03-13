//
//  ListPokemonViewController.swift
//  PokemonX
//
//  Created by Joel Ramirez on 09/03/23.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore

class ListPokemonViewController: UIViewController {
    //Variable bandera para saber si hay internet
     static var isConnected = true
     
    let pokeData = [PruebaPok(name: "Bulbasaur", image: "bulbasaur"),
                    PruebaPok(name: "Charizard", image: "charizard"),
                    PruebaPok(name: "Pikachu", image: "pikachu"),
                    PruebaPok(name: "Squirtle", image: "squirtle")]
    
    //varable del ViewModel para obtener los datos del servicio
    var viewModel = ListPokemonViewModel()
    
    var pokemomns = [Pokemon]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionPokemons.reloadData()
            }
        }
    }
        //Creación de variable privada de tipo UICollectionView, para mostrar la lista de pokemones en forma de grid
        private let collectionPokemons: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
            //layout.itemSize = CGSize(width: (collection.frame.width - layout.minimumInteritemSpacing) / 2, height: 300)
            layout.itemSize = .init(width: 184, height: 400)
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 2
            
            
            collection.translatesAutoresizingMaskIntoConstraints = false
            
            return collection
        }()
        
        
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(closeSession))
        
        //Añadir las vistas
        view.addSubview(collectionPokemons)
        
     /*
            Auth.auth().createUser(withEmail: "joelro_09@hotmail.com", password: "passwordfire") {
            (result, error) in
                if let result = result, error == nil {
                    print("oK created user firebase\(result)")
                } else {
                    print("Falló regiustrar usuario en Firebase")
                }
        }*/
        
        collectionPokemons.backgroundColor = .white
        collectionPokemons.dataSource = self
        collectionPokemons.delegate = self
        collectionPokemons.register(CustomCellPokemon.self, forCellWithReuseIdentifier: "CustomCellPokemon")
        
        
        
        NSLayoutConstraint.activate([collectionPokemons.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
                                     collectionPokemons.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2),
                                     collectionPokemons.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2),
                                     collectionPokemons.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)])
      if NetworkMonitor.isConnectedToNetwork() {
          ListPokemonViewController.isConnected = true
          viewModel.getPokemons()
          //Hacer el Binding con la vista
          
          viewModel.pokemons.bind { [weak self] pokemons in
              self?.pokemomns = pokemons
          }
          
      } else {
            print("NO HAY INTERNET")
          ListPokemonViewController.isConnected = false
          
      }
          
}
    
    @objc func closeSession() {
        if LoginViewController.isLoginFirebase == true {
            try? Auth.auth().signOut()
            print("Succes logout")
            LoginViewController.isLoginFirebase = false
        }
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ListPokemonViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if ListPokemonViewController.isConnected == true  {
            return self.pokemomns.count
        } else {
           return  self.pokeData.count
        }
       
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellPokemon", for: indexPath) as! CustomCellPokemon
        cell.backgroundColor = .white
        if ListPokemonViewController.isConnected == true {
            let model = pokemomns[indexPath.row]
            cell.pokemonList = model
            print("URL: \(model.url)")
        } else {
            let model = pokeData[indexPath.row]
            cell.configure(model: model)
        }
        
        return cell
    }
}

extension ListPokemonViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPokemonViewController()
        print("Se seleccionó la posición: \(indexPath.row) con el id \(indexPath.row + 1)")
        
        if ListPokemonViewController.isConnected == true {
            let model = pokemomns[indexPath.row]
            vc.idPokemon = indexPath.row + 1
            vc.nombre = model.name ?? "Charizard opt"
        } else {
            let model = pokeData[indexPath.row]
            vc.nombre = model.name
            vc.imagen = model.image
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
