//
//  ViewController.swift
//  RxLogin
//
//  Created by Aline Borges on 09/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftUtilities

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameValid: UILabel!
    @IBOutlet weak var passwordValid: UILabel!
    
    
    let service: Service = FakeService()
    
    let disposeBag = DisposeBag()
    
    let isLoading = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservables()
    }
    
    func setupViews() {
        self.usernameTextField.setPadding(20.0)
        self.passwordTextField.setPadding(20.0)
        //TODO: Tap do dismiss keyboard
    }
    
    func setupObservables() {
        
        let username = self.usernameTextField.rx.text.orEmpty.asObservable().share()
        let password = self.passwordTextField.rx.text.orEmpty.asObservable().share()
        let loginAction = self.loginButton.rx.tap.asObservable().share()
        
        let result = self.doLogin(username: username,
                     password: password,
                     loginAction: loginAction)
        
        self.isLoading.asDriver()
            .drive(self.activityIndicator.rx.isAnimating)
            .disposed(by: self.disposeBag)
        
        self.isLoading.asDriver()
            .map { !$0 }
            .drive(self.activityIndicator.rx.isHidden)
            .disposed(by: self.disposeBag)
    
        
        let passwordValid = self.isPasswordValid(password: password)
            .share()
        
        passwordValid
            .map { !$0 }
            .bind(to: self.passwordValid.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        let usernameValid = self.isUsernameValid(username: username).share()
        
        usernameValid
            .map { !$0 }
            .debug()
            .bind(to: self.usernameValid.rx.isHidden)
            .disposed(by: self.disposeBag)
        
        let isButtonEnabled =  self.isButtonEnabled(isLoading: isLoading.asObservable(),
                                                    isUsernameValid: usernameValid,
                                                    isPasswordValid: passwordValid)
            .share()
        
        isButtonEnabled
            .bind(to: self.loginButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        isButtonEnabled
            .map { $0 ? 1 : 0.5 }
            .bind(to: self.loginButton.rx.alpha)
            .disposed(by: self.disposeBag)
        
        result.subscribe(onNext: { result in
            self.showAlert(forResult: result)
        }).disposed(by: self.disposeBag)
    }
    
    func showAlert(forResult result: Result) {
        
        let alertController = UIAlertController(title: result.title, message: result.description, preferredStyle: .alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alertController.addAction(actionOk)
        
        self.present(alertController, animated: true, completion: nil)
        
    }

}

