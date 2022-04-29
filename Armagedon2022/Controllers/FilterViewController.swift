//
//  FilterViewController.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 27.04.2022.
//

import UIKit

protocol FilterViewControllerDelegate: AnyObject {
    func filterDidSelected(with distance: Distance, and isDangerous: Bool)
}

class FilterViewController: UIViewController {
    
    // MARK: - Public properties
    
    weak var delegate: FilterViewControllerDelegate?
    
    // MARK: - Private properties
    
    private var distance: Distance
    private var isDangerous: Bool
    private var selectedIndex = 0
    
    private lazy var filterTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UnitOfMeasureTableViewCell.self, forCellReuseIdentifier: "unitOfMeasure")
        tableView.register(DangerousTableViewCell.self, forCellReuseIdentifier: "dangerousCell")
        return tableView
    }()
    
    // MARK: - Initializers
    
    init() {
        guard let settings = SettingsManager.shared.loadSettingsButtons() else {
            isDangerous = false
            distance = .kilometers
            super.init(nibName: nil, bundle: nil)
            return
        }
        selectedIndex = settings.index
        isDangerous = settings.isDangerous
        distance = Distance.getFormat(atIndex: settings.index)
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
        view.addSubview(filterTableView)
        setupConstrains()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationController() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Titles.filter.title
        
        let backButton = UIBarButtonItem()
        backButton.title = Titles.back.title
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Titles.done.title, style: .done, target: self, action: #selector(rightBarButtonTapped))
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            filterTableView.topAnchor.constraint(equalTo: view.topAnchor),
            filterTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func rightBarButtonTapped() {
        delegate?.filterDidSelected(with: distance, and: isDangerous)
        let settings = SettingsButtonsManager(isDangerous: isDangerous, index: selectedIndex)
        SettingsManager.shared.setSettingsButtons(settingsButtons: settings)
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDelegate and UITableViewDataSource

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsUnitOfMeasureAndDangerous.getRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsUnitOfMeasureAndDangerous.getRow(atIndex: indexPath.row)
        
        switch cell {
        case .unitOfMeasure:
            guard let unitOfMeasureCell = tableView.dequeueReusableCell(withIdentifier: "unitOfMeasure", for: indexPath) as? UnitOfMeasureTableViewCell else { return UITableViewCell() }
            unitOfMeasureCell.delegate = self
            return unitOfMeasureCell
        case .isDangerous:
            guard let dangerCell = tableView.dequeueReusableCell(withIdentifier: "dangerousCell", for: indexPath) as? DangerousTableViewCell else { return UITableViewCell() }
            dangerCell.delegate = self
            return dangerCell
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: - UnitOfMeasureTableViewCellDelegate and DangerousTableViewCellDelegate

extension FilterViewController: UnitOfMeasureTableViewCellDelegate, DangerousTableViewCellDelegate {
    
    func changeDistanceFormat(distance: Distance, index: Int) {
        self.distance = distance
        selectedIndex = index
    }
    
    func setOnlyDangerousAsteroid(isDangerous: Bool) {
        self.isDangerous = isDangerous
    }
}
