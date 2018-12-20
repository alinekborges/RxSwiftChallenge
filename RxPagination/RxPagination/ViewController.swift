//
//  ViewController.swift
//  RxPagination
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: StatefulController<ViewModel.ViewState.State> {
    
    let viewModel: ViewModel = ViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func setupComponents() {
        
        self.register(state: .empty, view: <#T##ChildComponent.Type#>)
        
    }
    
    func setupViewModel() {
        let refreshControl = UIRefreshControl()
        
        self.tableView.refreshControl = refreshControl
        
        let refreshAction = refreshControl.rx
            .controlEvent(.valueChanged)
            .asObservable()
            .map { _ in return () }
        
        viewModel.bind(refreshAction: refreshAction)
    }
    
    func setupBindings() {
        
        let state = viewModel.viewState.map { $0.state }
        
        let data = viewModel.viewState.map { $0.data }
        
        
    }

}

protocol StateType: Hashable, RawRepresentable {
    var rawValue: String { get }
}

enum State: String, StateType {
    case something
}

class StatefulController<T: StateType>: UIViewController {
    
    private var currentView: ChildComponent?
    private var states: [String: ChildComponent.Type] = [:]
    private var statesView: [String: UIView] = [:]
    
    func register(state: T, view: ChildComponent.Type) {
        states[state.rawValue] = view
    }
    
    func register(state: T, view: UIView) {
        statesView[state.rawValue] = view
    }
    
    func setState(_ state: T) {
        if let stateType = states[state.rawValue] {
            showChildComponent(forType: stateType)
        }
    }
    
    private func showChildComponent(forType type: ChildComponent.Type) {
        let component = type.init()
        self.currentView?.hide()
        self.currentView = component
        component.show()
    }
}

extension Reactive where Base == StatefulController<State> {

    var state: Binder<State> {
        return Binder(self.base) { view, state in
            view.setState(state)
        }
    }
    
}

protocol ComponentController {
    func show()
    func hide()
}

typealias ChildComponent = ComponentController & UIViewController

class LoadingView: ChildComponent {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    func show() {
        print("showLoading")
    }
    
    func hide() {
        print("hideLoading")
    }
}

class ErrorView: ChildComponent {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    func show() {
        print("showError")
    }
    
    func hide() {
        print("hideError")
    }
}


