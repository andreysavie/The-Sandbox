//
//  AuthViewController.swift
//  The Sandbox
//
//  Created by Андрей Рыбалкин on 05.07.2022.
//

import UIKit
import Locksmith

class AuthViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: PROPERTIES ======================================================================
    
    private let passData = Locksmith.loadDataForUserAccount(userAccount: "user6")
    
    private var isPasswordExists = false {
        willSet {
            if newValue {
                enterButton.setTitle("Sign in", for: .normal)
                
            } else {
                enterButton.setTitle("Create password", for: .normal)
            }
        }
    }
    
    private lazy var authScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var logo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.alpha = 0.5
        button.isEnabled = false
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(enterButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        let icon = UIImageView(image: UIImage(systemName: "lock"))
        icon.tintColor = .brown
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        leftView.addSubview(icon)
        icon.center = leftView.center
        
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.placeholder = "Enter the pasword"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.brown.cgColor
        textField.layer.borderWidth = 0.25
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.layer.cornerRadius = 16
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.addTarget(self, action: #selector(enterButtonEnabled), for: .editingChanged)
        return textField
    }()
    
    
    // MARK: INITS ======================================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        passwordTextField.delegate = self
        isPasswordExists = passData != nil ? true : false
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        tabBarController?.tabBar.isHidden = false
//    }
    
    deinit {
        print("AUTH VC DEINITED") // УДАЛИТЬ
    }
    
    // MARK: METHODS ======================================================================
    
    
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .default) { _ in }
        alertController.addAction(acceptAction)
        self.present(alertController, animated: true)
    }
    
    
    // MARK: LAYOUT ======================================================================
    
    private func setupLayout() {
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        view.addSubview(authScrollView)
        
        authScrollView.addSubview(contentView)
        contentView.addSubview(logo)
        contentView.addSubview(enterButton)
        contentView.addSubview(passwordTextField)
        
        toAutolayout(
            authScrollView,
            contentView,
            logo,
            enterButton,
            passwordTextField)
        
        
        NSLayoutConstraint.activate([
            
            authScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            authScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            authScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            authScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: authScrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: authScrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: authScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: authScrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: authScrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: authScrollView.centerYAnchor),
            
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            enterButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            enterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
        
    }
    
    //MARK: SUBMETHODS
    
    var tempPass: String = "" {
        willSet {
            print(newValue)
        }
    }
    
    @objc
    private func enterButtonPressed() {
        
        if isPasswordExists {
            guard let pass = passData?["pass"] as? String else { return }
            if passwordTextField.text! == pass {
                print ("успешный вход!")
//                pushLoginViewController()
                dismiss(animated: true)
            } else {
                showAlert(title: "ERROR", message: "Password is wrong!")
            }
        } else {
            if tempPass == "" {
                tempPass = passwordTextField.text!
                passwordTextField.text = ""
                enterButtonEnabled()
                passwordTextField.placeholder = "Confim password"
                enterButton.setTitle("Confim password", for: .normal)
            } else {
                if passwordTextField.text! == tempPass {
                    do {
                        try Locksmith.saveData(data: ["pass": passwordTextField.text!], forUserAccount: "user6")
                        isPasswordExists = true
                        tempPass = ""
                        print ("успешная регистраиция и вход!!")
//                        pushLoginViewController()
                        dismiss(animated: true)

                    } catch {
                        print ("Unable to save password!")
                    }
                } else {
                    showAlert(title: "ERROR", message: "Пароли не совпадают!")
                }
            }
        }
    }
    
    private func pushLoginViewController() {
        let documentsViewController = DocumentsViewController()
//        navigationController?.popViewController(animated: false)
        navigationController?.pushViewController(documentsViewController, animated: true)
        navigationController?.setViewControllers([documentsViewController], animated: true)
    }
    
    
//    @objc
//    private func switchLogin() {
//        isPasswordExists.toggle()
//    }
    
    
    @objc
    private func enterButtonEnabled() {
        if passwordTextField.text!.count >= 4 {
            enterButton.alpha = 1.0
            enterButton.isEnabled = true
        } else {
            enterButton.alpha = 0.5
            enterButton.isEnabled = false
        }
    }

}




