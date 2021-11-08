//
//  Scenes.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//
import Foundation
import FOCalendar

class DiaryCardComponent: UIView {
    
    var controller: DiaryViewController?
    
    private lazy var imagePerfil: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showProfile))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapRecognizer)

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
    
    lazy var handleArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var indicator: UIView = {
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
        hierarchyView()
        setupConstraints()
        setupCalendar()
    }
    
    init(controller: DiaryViewController) {
        super.init(frame: .zero)
        self.controller = controller
    }
 
    func setModeCalendar(_ status: CardState) {
        switch status {
        case .expanded:
            calendar.setTypeCalendar(.expand)
        case .collapsed:
            calendar.setTypeCalendar(.compact)
        }
    }
    
    private func setupCalendar() {
        calendar.setCellStyle(cellFont: UIFont.graviolaRegular(size: 20) ?? .systemFont(ofSize: 20), cellColor: .white)
        calendar.setTitleStyle(titleFont: UIFont.graviolaRegular(size: 20) ?? .systemFont(ofSize: 20), titleColor: .white)
        calendar.setWeekStyle(weekStackFont: UIFont.graviolaSoft(size: 20) ?? .boldSystemFont(ofSize: 20), weekStackColor: .white)
        calendar.setSelectionRangeStyle(selectionRangeBackgroundColor: UIColor.greenMedium ?? .green, selectionRangeBorderColor: .clear, selectionRangeTextColor: .white)
        calendar.setSelectionDateStyle(color: .white, border: 0)
        calendar.setTypeCalendar(.compact)
    }
    
    private func hierarchyView() {
        addSubview(imagePerfil)
        addSubview(nameLabel)
        addSubview(progressBarComponent)
        addSubview(calendar)
        addSubview(handleArea)
        handleArea.addSubview(indicator)
    }
    
    private func setupConstraints() {
        imagePerfilSetupConstraints()
        nameLabelSetupConstraints()
        progressBarComponentSetupConstraints()
        calendarSetupConstraints()
        handleAreaSetupConstraints()
        indicatorSetupConstraints()
    }
    
    private func imagePerfilSetupConstraints() {
        
        NSLayoutConstraint.activate([
            imagePerfil.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.07),
            imagePerfil.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            imagePerfil.heightAnchor.constraint(equalToConstant: 38),
            imagePerfil.widthAnchor.constraint(equalTo: imagePerfil.heightAnchor)
        ])
    }
    
    private func nameLabelSetupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant:  UIScreen.main.bounds.height * 0.07),
            nameLabel.leadingAnchor.constraint(equalTo: imagePerfil.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.centerYAnchor.constraint(equalTo: imagePerfil.centerYAnchor)
        ])
    }
    
    private func progressBarComponentSetupConstraints() {
        progressBarComponent.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            progressBarComponent.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02),
            progressBarComponent.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            progressBarComponent.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            progressBarComponent.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func calendarSetupConstraints() {
        calendar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: progressBarComponent.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02),
            calendar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            calendar.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func handleAreaSetupConstraints() {
        NSLayoutConstraint.activate([
            handleArea.leadingAnchor.constraint(equalTo: leadingAnchor),
            handleArea.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleArea.bottomAnchor.constraint(equalTo: bottomAnchor),
            handleArea.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func indicatorSetupConstraints() {
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: handleArea.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: handleArea.centerYAnchor),
            indicator.widthAnchor.constraint(equalTo: handleArea.widthAnchor, multiplier: 0.3),
            indicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    func setUser(user: User?) {
        if let user = user {
            nameLabel.text = user.name
            let point: Float = Float(user.point >= 100 ? user.point % 100 : user.point)
            progressBarComponent.setProgressValue(value: point/100.0)

            if let imageData = user.icon {
                imagePerfil.image = UIImage(data: imageData)
            }
        }
    }
    
    func reloadCalendar() {
        calendar.reloadCalendarCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showProfile() {
        controller?.tabCoordinator?.showSettingsCoordinator()
    }
        
}
