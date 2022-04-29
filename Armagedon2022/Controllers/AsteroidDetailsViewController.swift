//
//  AsteroidDetailsViewController.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 27.04.2022.
//

import UIKit

class AsteroidDetailsViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var nearObjectsData: NearEarthObjects?
    
    private lazy var asteroidDetailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(AsteroidDetailsTableViewCell.self, forCellReuseIdentifier: "asteroidDetails")
        return tableView
    }()
    
    // MARK: - Initializers
    
    init(nearObjectsData: NearEarthObjects?) {
        guard let nearObjectsData = nearObjectsData else {
            super.init(nibName: nil, bundle: nil)
            return
        }
        self.nearObjectsData = nearObjectsData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationController()
        view.addSubview(asteroidDetailsTableView)
        setupConstrains()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = nearObjectsData?.name.changeAsteroidNameFormat
        
        let backButton = UIBarButtonItem()
        backButton.title = Titles.back.title
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            asteroidDetailsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            asteroidDetailsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            asteroidDetailsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            asteroidDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension AsteroidDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        DetailsDataTypes.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let asteroidCell = tableView.dequeueReusableCell(withIdentifier: "asteroidDetails", for: indexPath) as? AsteroidDetailsTableViewCell else { return UITableViewCell() }
        
        let detailsDataType = DetailsDataTypes.getRow(index: indexPath.section)
        guard let nearObjectsData = nearObjectsData else { return UITableViewCell() }
                
        asteroidCell.configure(for: nearObjectsData, detailsType: detailsDataType, index: indexPath.section)
        return asteroidCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
