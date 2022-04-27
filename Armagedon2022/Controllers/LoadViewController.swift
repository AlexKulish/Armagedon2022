//
//  ViewController.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 25.04.2022.
//

import UIKit

class LoadViewController: UIViewController {
    
    private var asteroid: Asteroid?
    
    private let loadAsteroidImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "loadAsteroid")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadAsteroidImageView)
        fetchAsteroid()
        setupConstrains()
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            loadAsteroidImageView.topAnchor.constraint(equalTo: view.topAnchor),
            loadAsteroidImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadAsteroidImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadAsteroidImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func setupTabBarAndNavigationBar() -> UITabBarController {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .lightGray
        
        let tabBarViewController = UITabBarController()
        let asteroidViewController = AsteroidViewController(asteroid: asteroid)
        let destroyViewController = DestroyViewController()
        
        let navigationAsteroidViewController = UINavigationController(rootViewController: asteroidViewController)
        let navigationDestroyViewController = UINavigationController(rootViewController: destroyViewController)
        tabBarViewController.setViewControllers([navigationAsteroidViewController, navigationDestroyViewController], animated: true)
        
        navigationAsteroidViewController.tabBarItem = UITabBarItem(title: Titles.asteroid.title, image: UIImage(systemName: "globe"), tag: 0)
        navigationDestroyViewController.tabBarItem = UITabBarItem(title: Titles.destroy.title, image: UIImage(systemName: "trash"), tag: 1)
        
        
        tabBarViewController.modalPresentationStyle = .overFullScreen
        return tabBarViewController
    }
    
    private func fetchAsteroid() {
        NetworkManager.shared.fetchData { [weak self] asteroid in
            guard let self = self else { return }
            self.asteroid = asteroid
            self.present(self.setupTabBarAndNavigationBar(), animated: true, completion: nil)
            
            print(asteroid)
        }
    }
}

