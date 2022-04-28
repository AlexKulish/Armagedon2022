//
//  DangerousTableViewCell.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import UIKit

protocol DangerousTableViewCellDelegate: AnyObject {
    func setOnlyDangerousAsteroid(isDangerous: Bool)
}

class DangerousTableViewCell: UITableViewCell {
    
    weak var delegate: DangerousTableViewCellDelegate?
    private var settings: SettingsButtonsManager?
    
    private lazy var dangerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = SettingsUnitOfMeasureAndDangerous.isDangerous.title
        return label
    }()
    
    private lazy var dangerSwitch: UISwitch = {
        let dangerSwitch = UISwitch()
        dangerSwitch.translatesAutoresizingMaskIntoConstraints = false
        dangerSwitch.isOn = settings?.isDangerous ?? false
        dangerSwitch.addTarget(self, action: #selector(dangerSwitchChanged), for: .allEvents)
        return dangerSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray5
        addSubview()
        setupConstrains()
        guard let settings = SettingsManager.shared.loadSettingsButtons() else { return }
        dangerSwitch.isOn = settings.isDangerous
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func dangerSwitchChanged() {
        delegate?.setOnlyDangerousAsteroid(isDangerous: dangerSwitch.isOn)
    }
    
    private func addSubview() {
        contentView.addSubview(dangerLabel)
        contentView.addSubview(dangerSwitch)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            dangerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dangerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dangerLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75),
            dangerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            dangerSwitch.topAnchor.constraint(equalTo: dangerLabel.topAnchor),
            dangerSwitch.leadingAnchor.constraint(equalTo: dangerLabel.trailingAnchor ,constant: 10),
            dangerSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            dangerSwitch.bottomAnchor.constraint(equalTo: dangerLabel.bottomAnchor)
        ])
    }
    
}
