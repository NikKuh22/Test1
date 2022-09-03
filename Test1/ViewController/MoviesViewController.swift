//
//  ViewController.swift
//  Test1
//
//  Created by Nikita Kukharchuk on 31.08.2022.
//

import UIKit

enum Section {
    case main
}

final class MoviesViewController: UIViewController {
    
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var yearTextField: UITextField!
    
    private var data = [MovieModel]()
    
    var dataSource: UITableViewDiffableDataSource<Section, MovieModel>!
    
    @IBAction private func addButton(_ sender: UIButton) {
        guard titleTextField.text?.isEmpty == false && yearTextField.text?.isEmpty == false else
        { return }
        let title = titleTextField.text ?? ""
        let year = Int(yearTextField.text ?? "") ?? 0
        
        addMovieInTableView(title: title, year: year)
        
        createSnapshot()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yearTextField.delegate = self
        
        tableView.register(
            UINib(nibName: "MoviesTableViewCell", bundle: .main),
            forCellReuseIdentifier: "MoviesTableViewCell")
        
        configureDataSource()
    }

}

extension MoviesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
}

extension MoviesViewController {
    func alert(movie: String) {
        let alert = UIAlertController(title: "Oops...", message: "\(movie) is already on the list", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    
    func addMovieInTableView(title: String, year: Int) {
        let obb = MovieModel(title: title, year: year)
        guard data.contains(where: { $0.title == obb.title }) == false else {
            alert(movie: obb.title);
            return
        }
        
        data.append(obb)
        
        titleTextField.text = ""
        yearTextField.text = ""
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, MovieModel>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
            cell.config(model: self.data[indexPath.row])
            return cell
        })
    }
    
    func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
    }
}

