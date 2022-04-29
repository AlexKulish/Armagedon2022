//
//  AsteroidDetailsTableViewCell.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 27.04.2022.
//

import UIKit

class AsteroidDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Private properties
    
    private let asteroidDetailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.addSubview(asteroidDetailsLabel)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            asteroidDetailsLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            asteroidDetailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            asteroidDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            asteroidDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Public methods
    
    func configure(for asteroidDetailsData: NearEarthObjects, detailsType: DetailsDataTypes, index: Int) {
        asteroidDetailsLabel.text = DetailsDataTypes.getRow(index: index).title + ": " + detailsType.getValue(from: asteroidDetailsData)
        
        if asteroidDetailsData.isPotentiallyHazardousAsteroid {
            asteroidDetailsLabel.changeIfNeedRangeColor(fullText: asteroidDetailsLabel.text ?? "", changeText: "опасен")
        }
    }
}
