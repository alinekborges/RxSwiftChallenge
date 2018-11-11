//
//  RxLogin.swift
//  RxLogin
//
//  Created by Aline Borges on 09/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftUtilities

extension ViewController {
    
    // Username should be VALID when more than 3 characters
    func isUsernameValid(username: Observable<String>) -> Observable<Bool> {
        return Observable.just(false)
    }
    
    // Password should be VALID when more than 3 characters
    func isPasswordValid(password: Observable<String>) -> Observable<Bool> {
        return Observable.just(false)
    }
    
    // Button should NEVER be enabled when isLoading
    // Button should be enabled when username AND password are both VALID
    func isButtonEnabled(isLoading: Observable<Bool>,
                         isUsernameValid: Observable<Bool>,
                         isPasswordValid: Observable<Bool>) -> Observable<Bool> {
        
        return Observable.just(false)
    }
    
    // Do login using `self.service.login(username: String, password: String) -> Single<Result>`
    // Result can be `.success` or `.failure`
    // Use `.trackActivity(self.isLoading)` on request to show loading in the view
    func doLogin(username: Observable<String>,
                 password: Observable<String>,
                 loginAction: Observable<Void>) -> Observable<Result> {
        
        return Observable.just(Result.failure(message: "Complete o código aqui!"))
        
    }
    
}
