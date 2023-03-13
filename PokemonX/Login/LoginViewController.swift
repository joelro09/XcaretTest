//
//  LoginViewController.swift
//  PokemonX
//
//  Created by Joel Ramirez on 07/03/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
   
   static  var  isLoginFirebase = false
    
    //enumeración para agregar los tipos de provedores para el login con Firebase
    enum ProviderType: String {
        case basic
    }
    
    //MARK: - Variables
    
    //Credenciales estaticas para simular logeo
    let usuario = "Rodrigo"
    let contrasena = "password"

    //private let provider: ProviderType?
    
    
    
    
    //MARK: - Variables de UI
    
    //variable privada de tipo UIImageView, para mostrar la imagen de pokemon_logo
    private let imageExample: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "pokemon_logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        image.widthAnchor.constraint(equalToConstant: 180).isActive = true
   
        return image
    }()
    
    //variable privada de tipo UIStackView, sera el contenedor de los inputs o textsfields para que el usuario ingrese su User y password
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        
        return stack
    }()
    
    //Varaible privada u Input de tipo UITextField, para que el usuario ingrese su User
    private let userText: UITextField = {
       let textField = UITextField()
        textField.backgroundColor = .white
        //textField.placeholder = "Ingresa tu usuario"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.layer.borderWidth = 1
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let attributedPlaceholder = NSAttributedString(string: "Ingresa tu usuario", attributes: attributes)
        textField.attributedText = attributedPlaceholder
        
        return textField
    }()
    
    //Varaible privada u Input de tipo UITextField, para que el usuario ingrese su Password
    private let passText: UITextField = {
       let passText = UITextField()
        passText.backgroundColor = .white
        //passText.placeholder = "Ingresa tu contraseña"
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let attributedPlaceholder = NSAttributedString(string: "Ingresa tu usuario", attributes: attributes)
        passText.attributedText = attributedPlaceholder
        passText.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passText.leftViewMode = .always
        passText.font = UIFont.systemFont(ofSize: 16)
        passText.layer.cornerRadius = 10
        passText.isSecureTextEntry = true
        passText.layer.borderColor = UIColor.blue.cgColor
        passText.layer.borderWidth = 1
        
        
        return passText
    }()
    
    //Variable privada tipo UIButton, será el botón de login
    private let loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        button.layer.cornerRadius = 10
        button.backgroundColor = .yellow.withAlphaComponent(0.9)
        button.addTarget(self, action: #selector(makeLogin), for: .touchUpInside)
        
        return button
    }()
    
    //Variable de tipo UILabel, contendra mensaje en caso de que se ingrensen mal las credenciales
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Invalid username and/or password: You did not provide a valid login"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        
        return label
    }()
    
    let wallPapperImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fondoLog")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "fondoLog")
            backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)
        
        addSubViews()
        configureConstraints()
        
        userText.delegate = self
        passText.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            view.addGestureRecognizer(tapGesture)
    }
    
    
    //MARK: - Functions Targets
    
    //Función que se llamara cuando el usuario de click o seleccione el botón de Sing in
    @objc func makeLogin() {
        guard let user = userText.text,
              let pass = passText.text else {
            print("Ingrese ambos valores")
            return
        }
        //showLoader()
    
        
    //--------- AUTENTICACIÖN LOCAL ESTATICA ----------
        print("VALOR FLAG FIREBASE: \(LoginViewController.isLoginFirebase)")
        
        if LoginViewController.isLoginFirebase == false {
            
            if user == usuario && pass == contrasena {
                print("Login OK")
                let rootVC = ListPokemonViewController()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: true)
            } else {
                errorLabel.isHidden  = false
            }
        }
       
        
        
        //   ----- AUTENTICACIÓN CON FIREBASE --------
            
           
           Auth.auth().signIn(withEmail: user, password: pass) {
               (result, error) in
               
               if error == nil {
                   
                   LoginViewController.isLoginFirebase = true
                   let rootVC = ListPokemonViewController()
                   let navVC = UINavigationController(rootViewController: rootVC)
                   navVC.modalPresentationStyle = .fullScreen
                   self.present(navVC, animated: true)
                   print("Succes login with firebase")
                   self.errorLabel.isHidden = true
               } else {
                   print("Error login with Firebase")
                   self.errorLabel.isHidden = false
               }
               
               
           }
      
            
        }
    
    
    //Función para ocultar el teclado
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Functions
    
    //Función privada que agrega las vistas al view Principal
    private func addSubViews() {
        [imageExample, containerStackView].forEach(view.addSubview)
    }
    
    //Función privada que agrega las constraints que tendra cada vista
    private func configureConstraints() {
        imageExample.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageExample.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        containerStackView.topAnchor.constraint(equalTo: imageExample.bottomAnchor, constant: 20).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        [userText, passText, loginButton, errorLabel].forEach(containerStackView.addArrangedSubview)
        userText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passText.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }



}

