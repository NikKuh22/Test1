//
//  MoviesTableViewCell.swift
//  Test1
//
//  Created by Никита Анонимов on 31.08.2022.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet var movieTitleAndYearLabel: UILabel!

    func config(model: String) {
        movieTitleAndYearLabel.text = model
    }
}
