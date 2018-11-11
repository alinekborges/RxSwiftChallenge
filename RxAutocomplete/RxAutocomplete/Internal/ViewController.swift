//
//  ViewController.swift
//  RxAutocomplete
//
//  Created by Aline Borges on 10/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var queryTextField: UITextField!
    
    let provider: CountryService = FakeCountryService()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupBindings()
    }
    
    func setupViews() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func setupBindings() {
        let query = queryTextField.rx.text.orEmpty.asObservable()
        
        let countries = self.filteredCountries(query: query)
        
        countries.bind(to: self.tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { _, element, cell in
                cell.textLabel?.text = element
                cell.textLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }.disposed(by: self.disposeBag)
    }

}


