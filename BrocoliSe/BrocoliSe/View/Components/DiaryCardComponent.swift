//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

class DiaryCardComponent: UIView {
    
    lazy var imagePerfil: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.graviolaSoft(size: 20)
        label.textColor = .white
        label.text = "Samuel"
        return label
    }()
    
    lazy var handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var indicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    let progressBarComponent = ProgressBarComponent()
    let calendar = FOCalendarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueDark
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true
        layer.cornerRadius  = 20
        calendar.setupCalendarView(modeCalendar: .compact,
                                   days: Set([]),
                                   titleFont: UIFont.graviolaRegular(size: 20) ?? .systemFont(ofSize: 20),
                                   titleColor: .white,
                                   weekStackFont: UIFont.graviolaSoft(size: 24) ?? .boldSystemFont(ofSize: 24),
                                   weekStackColor: .white,
                                   nextAndPreviousMonthColor: .white,
                                   cellFont: UIFont.graviolaRegular(size: 20) ?? .systemFont(ofSize: 20),
                                   cellTextColor: .white,
                                   selectionCellBackgroundColor: .white,
                                   selectionCellTextColor: UIColor.blueDark ?? .black,
                                   selectionRangeBackgroundColor: UIColor.green.withAlphaComponent(0.4),
                                   selectionRangeBorderColor: UIColor.green.withAlphaComponent(0.4),
                                   selectionRangeTextColor: .white)
        hierarchyView()
        setupConstraints()
    }
    
    func setModeCalendar(_ status: CardState) {
        switch status {
        case .expanded:
            calendar.setupCalendarView(modeCalendar: .expand)
        case .collapsed:
            calendar.setupCalendarView(modeCalendar: .compact)
        }
    }
    
    func hierarchyView() {
        addSubview(imagePerfil)
        addSubview(nameLabel)
        addSubview(progressBarComponent)
        addSubview(calendar)
        addSubview(handleArea)
        handleArea.addSubview(indicator)
    }
    
    func setupConstraints() {
        imagePerfilSetupConstraints()
        nameLabelSetupConstraints()
        progressBarComponentSetupConstraints()
        calendarSetupConstraints()
        handleAreaSetupConstraints()
        indicatorSetupConstraints()
    }
    
    func imagePerfilSetupConstraints() {
        NSLayoutConstraint.activate([
            imagePerfil.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            imagePerfil.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imagePerfil.heightAnchor.constraint(equalToConstant: 38),
            imagePerfil.widthAnchor.constraint(equalTo: imagePerfil.heightAnchor)
        ])
    }
    
    func nameLabelSetupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: imagePerfil.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: imagePerfil.centerYAnchor)
        ])
    }
    
    func progressBarComponentSetupConstraints() {
        progressBarComponent.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressBarComponent.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            progressBarComponent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBarComponent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBarComponent.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func calendarSetupConstraints() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: progressBarComponent.bottomAnchor, constant: 20),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            calendar.bottomAnchor.constraint(equalTo: handleArea.topAnchor, constant: -10)
        ])
    }
    
    func handleAreaSetupConstraints() {
        NSLayoutConstraint.activate([
            handleArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            handleArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            handleArea.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func indicatorSetupConstraints() {
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: handleArea.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: handleArea.centerYAnchor),
            indicator.widthAnchor.constraint(equalTo: handleArea.widthAnchor, multiplier: 0.3),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
}
