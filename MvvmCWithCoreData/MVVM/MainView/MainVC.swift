//
//  MainVC.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import UIKit
final class MainVC: UIViewController {
    
    private let viewModel: MainVM
    private let tableView = UITableView()
    private let cellIdentifier = "MainVCCell"
    fileprivate var datas = [Unit]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(viewModel: MainVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }
    
    @objc func addButton() {
        let controller = UIAlertController(title: "Unit", message: "Add new unit", preferredStyle: UIAlertController.Style.alert)
        controller.addTextField { (tf) in
            tf.placeholder = "Name"
        }
        
        let addButton = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            if let text = controller.textFields?.first?.text  {
                self.addNewUnit(text)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        controller.addAction(addButton)
        controller.addAction(cancelButton)
        present(controller, animated: true, completion: nil)
        
    }
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = datas[indexPath.row].name ?? "noName"
        return cell
    }
    
}

extension MainVC: MainVMDelegate {
    
    func mainVMLoadData(_ datas: [Unit]) {
        self.datas = datas
    }
    
    func mainVMError(_ error: NSError) {
        print("[ViewModel Error] \(error.localizedDescription)")
    }
    
}

extension MainVC {
    
    fileprivate func addNewUnit(_ name: String) {
        viewModel.addNewUnit(name)
    }
    
}



