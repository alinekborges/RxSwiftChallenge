//
//  ViewModel.swift
//  RxPagination
//
//  Created by Aline Borges on 20/12/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    private let service: CitiesService
    private let mapper: Mapper
    
    var viewState: Observable<ViewState>!
    
    init(service: CitiesService = CitiesJsonService(),
         mapper: Mapper = .init()) {
        self.service = service
        self.mapper = mapper
    }
    
    func bind(refreshAction: Observable<Void>) {
        
        self.viewState = refreshAction
            .startWith(())
            .flatMapLatest { [unowned self] in
                self.service.getCities(lastId: "")
            }.map(Mapper().map)
            .materialize()
            .scan(ViewState(.empty), accumulator: Reducer().reduce)
        
    }
    
    struct ViewState {
        
        let data: [CityDisplay]
        
        let state: State
        
        enum State: String, StateType {
            case empty
            case loading
            case success
            case error
            case errorWithContent
            case finished
        }
        
        init(_ state: State, data: [CityDisplay] = []) {
            self.state = state
            self.data = data
        }
    }
}

class Reducer {
    
    func reduce(_ oldState: ViewModel.ViewState, _ result: Event<[CityDisplay]>) -> ViewModel.ViewState {
        switch result {
        case .next(let data):
            if oldState.state == .empty {
                return .init(.success, data: data)
            } else {
                return .init(.success, data: oldState.data + data)
            }
        case .error:
            if oldState.state == .empty {
                return .init(.error)
            } else {
                return .init(.errorWithContent)
            }
        default:
            return .init(.finished)
        }
    }
}

class Mapper {

    func map(_ cities: [City]) -> [CityDisplay] {
        return cities.map { CityDisplay.init(name: $0.name) }
    }
    
}

struct CityDisplay {
    let name: String
}


