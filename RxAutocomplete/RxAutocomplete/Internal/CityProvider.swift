//
//  Service.swift
//  RxAutocomplete
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

protocol CountryProvider {
    
    func getCountry() -> Observable<[String]>
    
}

class LocalCountryProvider: CountryProvider {
    
    let service: CountryService
    
    init(service: CountryService = NetworkCountryService()) {
        self.service = service
    }
    
    func getCountry() -> Observable<[String]> {
        return self.service.getCountries()
    }
    
}
