//
//  DestroyViewController.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

class DestroyViewController: UIViewController {
    
    // MARK: - Public properties
    
    var destroyAsteroidList: [NearEarthObjects] = [] {
        didSet {
            destroyAsteroidTableView.reloadData()
        }
    }
    
    lazy var destroyAsteroidTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DestroyTableViewCell.self, forCellReuseIdentifier: "destroyCell")
        return tableView
    }()
    
    // MARK: - Private properties
    
    private let sendBrigadeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.layer.cornerRadius = 15
        button.setTitle("Отправить бригаду", for: .normal)
        button.addTarget(self, action: #selector(sendBrigadeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setupNavigationController()
        addSubview()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        destroyAsteroidList = DestroyManager.shared.destroyAsteroids
    }
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Titles.destroy.title
    }
    
    private func addSubview() {
        view.addSubview(destroyAsteroidTableView)
        view.addSubview(sendBrigadeButton)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            destroyAsteroidTableView.topAnchor.constraint(equalTo: view.topAnchor),
            destroyAsteroidTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            destroyAsteroidTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            destroyAsteroidTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85)
        ])
        
        NSLayoutConstraint.activate([
            sendBrigadeButton.topAnchor.constraint(equalTo: destroyAsteroidTableView.bottomAnchor),
            sendBrigadeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            sendBrigadeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            sendBrigadeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func sendBrigadeButtonPressed() {
        let alert = UIAlertController(title: AlertsTitle.askForAction.title, message: AlertsTitle.messageDescription.title, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: AlertsTitle.ok.title, style: .default) { _ in
            self.destroyAsteroidList.removeAll()
            DestroyManager.shared.destroyAsteroids.removeAll()
            
            let descriptionAlert = UIAlertController(title: AlertsTitle.congrats.title, message: AlertsTitle.congratsDescription.title, preferredStyle: .alert)
            let okAction = UIAlertAction(title: AlertsTitle.ok.title, style: .default, handler: nil)
            descriptionAlert.addAction(okAction)
            self.present(descriptionAlert, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: AlertsTitle.cancel.title, style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension DestroyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        destroyAsteroidList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let destroyCell = tableView.dequeueReusableCell(withIdentifier: "destroyCell", for: indexPath) as? DestroyTableViewCell else { return UITableViewCell() }
        destroyCell.configure(with: destroyAsteroidList[indexPath.row])
        return destroyCell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
