//
//  FakeService.swift
//  RxSearch
//
//  Created by Aline Borges on 09/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

struct Student {
    var name: String
    var age: String
}

protocol Service {
    
    func getListOfStudents() -> Single<[String]>
    
}

class FakeService: Service {
    
    private var studentList = ["Aline", "Allan", "Alexandre", "Bruno"]
    
    func getListOfStudents() -> Single<[String]> {
        return Single.just(studentList)
            .delaySubscription(0.5, scheduler: MainScheduler.instance)
    }
    
}
