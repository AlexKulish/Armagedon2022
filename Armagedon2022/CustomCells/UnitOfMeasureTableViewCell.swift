//
//  UnitOfMeasureTableViewCell.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 28.04.2022.
//

import UIKit

protocol UnitOfMeasureTableViewCellDelegate: AnyObject {
    func changeDistanceFormat(distance: Distance, index: Int)
}

class UnitOfMeasureTableViewCell: UITableViewCell {
    
    weak var delegate: UnitOfMeasureTableViewCellDelegate?
    private var settings: SettingsButtonsManager?
    
    private lazy var unitOfMeasureDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = SettingsUnitOfMeasureAndDangerous.unitOfMeasure.title
        return label
    }()
    
    private lazy var unitOfMeasureSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: Distance.kilometers.distanceFormat, at: Distance.kilometers.rawValue, animated: true)
        segmentedControl.insertSegment(withTitle: Distance.lunar.distanceFormat, at: Distance.lunar.rawValue, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(unitOfMeasureValueChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray5
        addSubview()
        setupConstrains()
        guard let settings = SettingsManager.shared.loadSettingsButtons() else { return }
        unitOfMeasureSegmentedControl.selectedSegmentIndex = settings.index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func unitOfMeasureValueChanged() {
        let index = unitOfMeasureSegmentedControl.selectedSegmentIndex
        let format = Distance.getFormat(atIndex: index)
        delegate?.changeDistanceFormat(distance: format, index: index)
    }
    
    private func addSubview() {
        contentView.addSubview(unitOfMeasureDescriptionLabel)
        contentView.addSubview(unitOfMeasureSegmentedControl)
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            unitOfMeasureDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            unitOfMeasureDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            unitOfMeasureDescriptionLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            unitOfMeasureDescriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            unitOfMeasureSegmentedControl.topAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.topAnchor),
            unitOfMeasureSegmentedControl.leadingAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.trailingAnchor),
            unitOfMeasureSegmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            unitOfMeasureSegmentedControl.bottomAnchor.constraint(equalTo: unitOfMeasureDescriptionLabel.bottomAnchor)
        ])
    }
    
}
