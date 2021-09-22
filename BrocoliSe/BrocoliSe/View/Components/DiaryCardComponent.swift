//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

class DiaryCardComponent: UIView {
    
    private lazy var imagePerfil: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.graviolaSoft(size: 20)
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    private let progressBarComponent = ProgressBarComponent()
    private let calendar = FOCalendarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blueDark
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.masksToBounds = true
        layer.cornerRadius  = 20
        calendar.setupCalendarView(modeCalendar: .expand,
                                   days: Set([]),
                                   titleFont: UIFont.graviolaRegular(size: 20) ?? .systemFont(ofSize: 20),
                                   titleColor: .white,
                                   weekStackFont: UIFont.graviolaSoft(size: 24) ?? .boldSystemFont(ofSize: 24),
                                   weekStackColor: .white,
                                   nextAndPreviousMonthColor: .white,
                                   cellFont: UIFont.graviolaRegular(size: 24) ?? .systemFont(ofSize: 24),
                                   cellTextColor: .white,
                                   selectionCellBackgroundColor: .white,
                                   selectionCellTextColor: UIColor.blueDark ?? .black,
                                   selectionRangeBackgroundColor: UIColor.green.withAlphaComponent(0.4),
                                   selectionRangeBorderColor: UIColor.green.withAlphaComponent(0.4),
                                   selectionRangeTextColor: .white)
        hierarchyView()
        setupConstraints()
    }
    
    private func hierarchyView() {
        addSubview(imagePerfil)
        addSubview(nameLabel)
        addSubview(progressBarComponent)
        addSubview(calendar)
    }
    
    private func setupConstraints() {
        imagePerfilSetupConstraints()
        nameLabelSetupConstraints()
        progressBarComponentSetupConstraints()
        calendarSetupConstraints()
    }
    
    private func imagePerfilSetupConstraints() {
        NSLayoutConstraint.activate([
            imagePerfil.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            imagePerfil.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imagePerfil.heightAnchor.constraint(equalToConstant: 38),
            imagePerfil.widthAnchor.constraint(equalTo: imagePerfil.heightAnchor)
        ])
    }
    
    private func nameLabelSetupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: imagePerfil.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: imagePerfil.centerYAnchor)
        ])
    }
    
    private func progressBarComponentSetupConstraints() {
        progressBarComponent.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressBarComponent.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            progressBarComponent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBarComponent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBarComponent.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func calendarSetupConstraints() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: progressBarComponent.bottomAnchor, constant: 25),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            calendar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func setUser(user: User?) {
        if let user = user {
            nameLabel.text = user.name
            progressBarComponent.setProgressValue(value: Float(user.point)/100.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
}
