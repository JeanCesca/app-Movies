//
//  MovieCell.swift
//  AppArchitecture
//
//  Created by Vincent on 09/05/2022.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let id = "MovieCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label teste"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview Label teste"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            overviewLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configureCell(model: Movie) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
    }
    
}
