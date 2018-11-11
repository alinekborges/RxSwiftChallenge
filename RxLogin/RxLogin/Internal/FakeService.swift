//
//  FakeService.swift
//  RxLogin
//
//  Created by Aline Borges on 09/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

enum Result {
    case success, failure(message: String)
}

extension Result {
    var description: String {
        switch self {
        case .success:
            return ""
        case .failure(let message):
            return message
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return "Sucesso!"
        case .failure:
            return "Erro!"
        }
    }
}

protocol Service {
    
    func login(username: String, password: String) -> Single<Result>
    
}

class FakeService: Service {
    
    func login(username: String, password: String) -> Single<Result> {
        
        var result: Result = .failure(message: "Email e senha incorretos")
        
        if username == "admin" && password == "admin" {
            result = .success
        }
        
        return Single.just(result)
            .delaySubscription(0.5, scheduler: MainScheduler.instance)
    }
    
}
