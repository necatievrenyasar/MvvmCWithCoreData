//
//  DetailVC.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import UIKit
import CoreData
final class DetailVC: UIViewController {
    
    private let viewModel: DetailVM
    private let tableView = UITableView()
    private let cellIdentifier = "DetailVCCell"
    
    init(viewModel: DetailVM) {
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
    
    @objc func addButton() {
        let controller = UIAlertController(title: "Unit", message: "Add new unit", preferredStyle: UIAlertController.Style.alert)
        controller.addTextField { (tf) in
            tf.placeholder = "Word"
        }
        controller.addTextField { (tf) in
            tf.placeholder = "Meaning"
        }
        
        let addButton = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (action) in
            if let textFields = controller.textFields,
                let newWord = textFields[0].text, let newMeaning = textFields[1].text{
                self.viewModel.add(newWord, newMeaning)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        controller.addAction(addButton)
        controller.addAction(cancelButton)
        present(controller, animated: true, completion: nil)
        
    }
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource  {
    
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
        return viewModel.dataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = viewModel.getObject(indexPath)
        cell.textLabel?.text = model?.word ?? "noName"
        return cell
    }
}

extension DetailVC: DetailVMDelegate {
    func detailVMError(_ error: NSError) {
        print("[Detail Error] \(error.userInfo)")
    }
    
    func detailVMRefresh(indexPath: IndexPath, type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            tableView.endUpdates()
        default:
            ()
        }
    }
    
    
}
