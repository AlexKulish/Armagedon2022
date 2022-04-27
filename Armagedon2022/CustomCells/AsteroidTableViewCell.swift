//
//  AsteroidTableViewCell.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

protocol AsteroidTableViewCellDelegate: AnyObject {
    func destroyButtonTapped(index: Int)
}

class AsteroidTableViewCell: UITableViewCell {
    
    weak var delegate: AsteroidTableViewCellDelegate?
    private var gradientColors: [CGColor] = []
    private var index: Int?
    
    private lazy var destroyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .blue
        button.setTitle(Titles.destroy.title, for: .normal)
        button.addTarget(self, action: #selector(destroyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let asteroidImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .topLeft
        return imageView
    }()
    
    private let dinoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "dino")
        return imageView
    }()
    
    private let asteroidNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let approachDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let hazardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.setGradientBackground(colors: gradientColors)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        guard let sublayers = containerView.layer.sublayers else { return }
        for sublayer in sublayers {
            if sublayer.name == "gradient" {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    @objc private func destroyButtonTapped() {
        delegate?.destroyButtonTapped(index: index ?? 0)
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        
        containerView.addSubview(asteroidImageView)
        containerView.addSubview(asteroidNameLabel)
        containerView.addSubview(dinoImageView)
        
        contentView.addSubview(destroyButton)
        contentView.addSubview(diameterLabel)
        contentView.addSubview(approachDateLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(hazardLabel)
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            asteroidImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            asteroidImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            asteroidImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            asteroidImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            asteroidNameLabel.topAnchor.constraint(equalTo: asteroidImageView.bottomAnchor, constant: 20),
            asteroidNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            asteroidNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            asteroidNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.75)
        ])
        
        NSLayoutConstraint.activate([
            dinoImageView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.15),
            dinoImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dinoImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dinoImageView.centerYAnchor.constraint(equalTo: asteroidNameLabel.centerYAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            diameterLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            diameterLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            diameterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            diameterLabel.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.2)
        ])
        
        NSLayoutConstraint.activate([
            approachDateLabel.topAnchor.constraint(equalTo: diameterLabel.bottomAnchor, constant: 5),
            approachDateLabel.leadingAnchor.constraint(equalTo: diameterLabel.leadingAnchor),
            approachDateLabel.trailingAnchor.constraint(equalTo: diameterLabel.trailingAnchor),
            approachDateLabel.heightAnchor.constraint(equalTo: diameterLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: approachDateLabel.bottomAnchor, constant: 5),
            distanceLabel.leadingAnchor.constraint(equalTo: diameterLabel.leadingAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: diameterLabel.trailingAnchor),
            distanceLabel.heightAnchor.constraint(equalTo: diameterLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hazardLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 10),
            hazardLabel.leadingAnchor.constraint(equalTo: diameterLabel.leadingAnchor),
            hazardLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            hazardLabel.heightAnchor.constraint(equalTo: diameterLabel.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            destroyButton.topAnchor.constraint(equalTo: hazardLabel.topAnchor),
            destroyButton.leadingAnchor.constraint(equalTo: hazardLabel.trailingAnchor),
            destroyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            destroyButton.bottomAnchor.constraint(equalTo: hazardLabel.bottomAnchor)
        ])
        
    }
    
    func configure(with asteroidData: NearEarthObjects, distance: Distance, index: Int) {
        self.index = index
        
        guard let firstObject = asteroidData.closeApproachData.first else { return }
        
        let approachDate = Date.changeAsteroidApproachDateFormat(approachDate: firstObject.closeApproachDate)
        
        let diameter = asteroidData.estimatedDiameter.meters.estimatedDiameterMax
        let isHazard = asteroidData.isPotentiallyHazardousAsteroid
        
        asteroidNameLabel.text = asteroidData.name.changeAsteroidNameFormat
        diameterLabel.text = "Диаметр: \(Int(diameter)) м"
        approachDateLabel.text = "Подлетает \(approachDate)"
        
        let size = AsteroidSize.size(for: Int(diameter))
        asteroidImageView.image = size.asteroidImage
        
        switch distance {
        case .kilometers:
            guard let kilometerDistance = asteroidData.closeApproachData.first?.missDistance.kilometers else { return }
            let correctDistance = kilometerDistance.changeValueFormatDistanceToEarth(distance: kilometerDistance)
            distanceLabel.text = "на расстояние \(correctDistance) \(distance.distanceFormat)"
        case .lunar:
            guard let lunarDistance = asteroidData.closeApproachData.first?.missDistance.lunar else { return }
            let correctDistance = lunarDistance.changeValueFormatDistanceToEarth(distance: lunarDistance)
            distanceLabel.text = "на расстояние \(correctDistance) \(distance.distanceFormat)"
        }
        
        switch isHazard {
        case true:
            let firstGradientColor = CGColor(red: 244 / 255, green: 177 / 255, blue: 156 / 255, alpha: 1)
            let secondGradientColor = CGColor(red: 255 / 255, green: 54 / 255, blue: 77 / 255, alpha: 1)
            
            hazardLabel.changeIfNeedRangeColor(fullText: "Оценка: опасен", changeText: "опасен")
            gradientColors = [firstGradientColor, secondGradientColor]
            
        case false:
            let firstGradientColor = CGColor(red: 208 / 255, green: 235 / 255, blue: 137 / 255, alpha: 1)
            let secondGradientColor = CGColor(red: 154 / 255, green: 230 / 255, blue: 148 / 255, alpha: 1)
            
            hazardLabel.text = "Оценка: не опасен"
            gradientColors = [firstGradientColor, secondGradientColor]
        }
        
    }
}
