//
//  ViewController.swift
//  RxSearch
//
//  Created by Aline Borges on 09/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftUtilities

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    var refreshControl: UIRefreshControl!
    var searchController: UISearchController!
    
    let service: Service = FakeService()

    let disposeBag = DisposeBag()
    
    let isLoadingIndicator = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchController = UISearchController(searchResultsController:  nil)
        self.navigationItem.titleView = searchController.searchBar
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = false
        
        self.searchController.searchBar.barStyle = .default
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = "List"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.setupBindings()

    }
    
    func setupBindings() {
        
        let refreshTrigger = self.refreshButton.rx.tap.asObservable()
        let search = self.searchController.searchBar.rx.text.orEmpty.asObservable()
        
        let items = self.getSearchItems(refreshTrigger: refreshTrigger,
                                        search: search).share()
        
        items.bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { _, element, cell in
                cell.textLabel?.text = element
            }.disposed(by: self.disposeBag)

        items.subscribe(onNext: { _ in
            print("refreshed!")
        }).disposed(by: self.disposeBag)
        
        //TODO: show loading
        
    }


}

extension ViewController {
    
    func getSearchItems(refreshTrigger: Observable<Void>,
                          search: Observable<String>) -> Observable<[String]> {
        
        let list = getItems(refreshTrigger: refreshTrigger)
        
        return search
            .withLatestFrom(list) { query, list in
                return list.filter { $0.contains(query) }
            }.flatMapFirst {
                return self.service.getListOfStudents()
                    .trackActivity(self.isLoadingIndicator)
        }
        
    }

    func getItems(refreshTrigger: Observable<Void>) -> Observable<[String]> {

        return refreshTrigger.startWith(()).flatMap {
            return self.service
                .getListOfStudents()
                .trackActivity(self.isLoadingIndicator)
        }
    }   
}
