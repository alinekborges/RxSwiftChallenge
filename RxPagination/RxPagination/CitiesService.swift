//
//  CityService.swift
//  RxPagination
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

protocol CitiesService {

    func getCities(page: Int) -> Single<[String]>
    
}

class CitiesJsonService: CitiesService {
    
    var cities: [String] = []
    
    init() {
        
        do {
            if let jsonPath = Bundle.main.url(forResource: "CitiesJson", withExtension: "json"){
                let jsonData = try Data(contentsOf: jsonPath)
                self.cities = try JSONDecoder().decode([City].self, from: jsonData)
                    .map { $0.name }
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func getCities(page: Int) -> Single<[String]> {
        return Single.just(self.cities)
    }
    
    
}

struct City: Codable {
    let name: String
}
