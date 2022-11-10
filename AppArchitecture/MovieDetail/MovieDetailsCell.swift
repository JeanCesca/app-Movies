//
//  MovieDetailsCell.swift
//  AppArchitecture
//
//  Created by Jean Ricardo Cesca on 10/11/22.
//

import UIKit

class MovieDetailsCell: UITableViewCell {
    
    static let id = "MovieDetailsCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Label teste"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
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
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    public func configureCell(model: MovieCastMember) {
        titleLabel.text = model.name
        overviewLabel.text = model.character
    }
    
}

