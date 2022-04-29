//
//  DestroyTableViewCell.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import UIKit

class DestroyTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let asteroidNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(asteroidNameLabel)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            asteroidNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            asteroidNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            asteroidNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asteroidNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func configure(with nearObjectData: NearEarthObjects) {
        switch nearObjectData.isPotentiallyHazardousAsteroid {
        case true:
            backgroundColor = .red
            asteroidNameLabel.textColor = .white
            backgroundColor = UIColor(red: 255 / 255, green: 54 / 255, blue: 77 / 255, alpha: 1)
        case false:
            backgroundColor = UIColor(red: 154 / 255, green: 230 / 255, blue: 148 / 255, alpha: 1)
        }
        
        asteroidNameLabel.text = nearObjectData.name.changeAsteroidNameFormat
    }
}
