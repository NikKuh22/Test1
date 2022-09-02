//
//  ViewController.swift
//  Test1
//
//  Created by Nikita Kukharchuk on 31.08.2022.
//

import UIKit

final class MoviesViewController: UIViewController {
    
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var yearTextField: UITextField!
    
    var movieTitleAndYearModel = [String]()
    
    @IBAction func addButton(_ sender: UIButton) {
        guard titleTextField.text?.isEmpty == false && yearTextField.text?.isEmpty == false else
        { return }
        let title = titleTextField.text
        let year = yearTextField.text
        
        addMovieInTableView(title: title, year: year)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        yearTextField.delegate = self
        
        tableView.register(
            UINib(nibName: "MoviesTableViewCell", bundle: .main),
            forCellReuseIdentifier: "MoviesTableViewCell")
    }

}

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as! MoviesTableViewCell
        cell.config(model: movieTitleAndYearModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieTitleAndYearModel.count
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
    func alert(str: String) {
        let alert = UIAlertController(title: "Oops...", message: "\(str) is already on the list", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    
    func addMovieInTableView(title: String?, year: String?) {
        let str = "\(title ?? "") \(year ?? "")"
        guard movieTitleAndYearModel.contains(str) == false else {
            alert(str: str);
            return }
        
        movieTitleAndYearModel.append(str)
        
        tableView.reloadData()
        titleTextField.text = ""
        yearTextField.text = ""
    }
}

