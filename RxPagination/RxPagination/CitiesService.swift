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

    func getCities(lastId: String) -> Single<[City]>
    
}

class CitiesJsonService: CitiesService {
    
    var cities: [City] = []
    
    init() {
        
        do {
            if let jsonPath = Bundle.main.url(forResource: "CitiesJson", withExtension: "json"){
                let jsonData = try Data(contentsOf: jsonPath)
                self.cities = try JSONDecoder().decode([City].self, from: jsonData)
            }
        } catch let error {
            print(error)
        }
        
    }
    
    func getCities(lastId: String) -> Single<[City]> {
        return Single.just(self.cities)
    }
    
    
}

struct City: Codable {
    let name: String
}
