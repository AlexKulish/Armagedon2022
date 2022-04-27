//
//  AsteroidViewController.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

protocol AsteroidViewControllerDelegate: AnyObject {
    func didSelect()
}

class AsteroidViewController: UIViewController {
    
    private var asteroid: Asteroid?
    private var asteroidsData: [NearEarthObjects] = []
    private var dangerousAsteroids: [NearEarthObjects] = []
    private var distance: Distance?
    private var isPaging = true
    private var isDangerous = false
    weak var delegate: AsteroidViewControllerDelegate?
    
    private lazy var asteroidTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AsteroidTableViewCell.self, forCellReuseIdentifier: "asteroidTableViewCell")
        return tableView
    }()
    
    init(asteroid: Asteroid?) {
        self.asteroid = asteroid
        super.init(nibName: nil, bundle: nil)
        guard let asteroidsData = self.asteroid?.nearEarthObjects[NetworkManager.shared.correctRequestDay] else { return }
        self.asteroidsData.append(contentsOf: asteroidsData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(asteroidTableView)
        setupConstrains()
        setupNavigationBar()
        
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            asteroidTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            asteroidTableView.topAnchor.constraint(equalTo: view.topAnchor),
            asteroidTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            asteroidTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemGray6
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = Titles.armagedon.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    private func fetchDataByScroll() {
        isPaging = false
        
        NetworkManager.shared.requestDay = Calendar.current.date(byAdding: .day, value: 1, to: NetworkManager.shared.requestDay) ?? Date()
        
        NetworkManager.shared.fetchData { [weak self] asteroid in
            guard let self = self else { return }
            
            self.asteroidsData.append(contentsOf: asteroid.nearEarthObjects[NetworkManager.shared.correctRequestDay] ?? [])
            
            self.dangerousAsteroids.append(contentsOf: self.asteroidsData.filter { asteroid in
                asteroid.isPotentiallyHazardousAsteroid == true && !self.dangerousAsteroids.contains(where: { dangerousAsteroid in
                    dangerousAsteroid.name == asteroid.name
                })})
            
            if self.dangerousAsteroids.count < 2 {
                self.fetchDataByScroll()
            }
            
            self.asteroidTableView.reloadData()
            self.isPaging = true
            
        }
        
    }
    
    @objc private func rightBarButtonTapped() {
        
    }
    
}


extension AsteroidViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let asteroidCell = tableView.dequeueReusableCell(withIdentifier: "asteroidTableViewCell", for: indexPath) as? AsteroidTableViewCell else { return UITableViewCell() }
        
        let asteroidInfo = isDangerous ? dangerousAsteroids[indexPath.section] : asteroidsData[indexPath.section]
        asteroidCell.delegate = self
        
        asteroidCell.configure(with: asteroidInfo, distance: distance ?? Distance.kilometers, index: indexPath.section)
        
        return asteroidCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        isDangerous ? dangerousAsteroids.count : asteroidsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let asteroidDetailsViewController = AsteroidDetailsViewController(nearObjectsData: isDangerous ? dangerousAsteroids[indexPath.section] : asteroidsData[indexPath.section])
        
        navigationController?.pushViewController(asteroidDetailsViewController, animated: true)
    }

}

extension AsteroidViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > asteroidTableView.contentSize.height - 100 - scrollView.frame.height, isPaging {
            fetchDataByScroll()
        }
    }
    
}

extension AsteroidViewController: AsteroidTableViewCellDelegate {
    
    
    func destroyButtonTapped(index: Int) {
        print("Hello")
    }
    

    
}
