//
//  CountryAutocomplete.swift
//  RxAutocomplete
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

extension ViewController {
    
    // **Should return the list of countries that contains a certain Query**
    // Use `self.provider.getCountries()` to get the full list of countries
    func filteredCountries(query: Observable<String>) -> Observable<[String]> {
        
        //TODO: Implement!
        return Observable.just([])
        
    }
    
}
