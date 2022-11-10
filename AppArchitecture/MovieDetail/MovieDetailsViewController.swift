//
//  MovieDetailsViewController.swift
//  AppArchitecture
//
//  Created by Vincent on 09/05/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview Label teste"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieDetailsCell.self, forCellReuseIdentifier: MovieDetailsCell.id)
        return tableView
    }()

    let viewModel: MovieDetailsViewModel
    
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(containerView)
        containerView.addSubview(posterImageView)
        containerView.addSubview(overviewLabel)
        view.addSubview(tableView)
        configureConstraints()
        
        setupNavBar()

        tableView.dataSource = self
    
        viewModel.fetchData()
        updateUI()
    }
    
    private func setupNavBar() {
        navigationItem.title = viewModel.movie.title
    }
    
    private func updateUI() {
        overviewLabel.text = viewModel.movie.overview
        
        viewModel.poster.onUpdate = { [weak self] poster in
            self?.posterImageView.image = poster
        }
        
        viewModel.cast.onUpdate = { [weak self] cast in
            self?.tableView.reloadData()
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: view.frame.width - 150),
            
            posterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5),
            
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            overviewLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            overviewLabel.centerYAnchor.constraint(equalTo: posterImageView.centerYAnchor),
            overviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cast.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsCell.id, for: indexPath) as? MovieDetailsCell else {
            return UITableViewCell()
        }
        
        let castMember = viewModel.cast.value[indexPath.row]
        cell.configureCell(model: castMember)

        return cell
    }
}
