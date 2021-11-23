//
//  ProfileScene.swift
//  ProfileScene
//
//  Created by Larissa Uchoa on 26/10/21.
//

import UIKit

class ProfileScene: UIView {
    private var isActiveKeyboard: Bool = false
    private var controller: ProfileViewController?
    private var profileModel: ProfileModel?

    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Foto"
        label.textAlignment = .left
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private lazy var customImagePicker: CustomImagePicker = CustomImagePicker(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.25))

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.textAlignment = .left
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private let nameTextField: TextField = TextField()

    private lazy var foodSelectorLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione os alimentos não consumidos"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private let foodSelector: FoodSelectorComponent = FoodSelectorComponent()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [photoLabel, customImagePicker, nameLabel, nameTextField, foodSelectorLabel, foodSelector, spacer])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 20 : 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupConstraints()
        customImagePicker.selectPhotoDelegate = self

        setupKeyboardGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupKeyboardGesture() {
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide(notification:)))
        addGestureRecognizer(tapDismiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            isActiveKeyboard = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        isActiveKeyboard = false
        nameTextField.dismissKeyborad()
    }

    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    private func showImagePickerOptions() {
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Tirar foto", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.controller?.present(cameraImagePicker, animated: true)
        }

        let libraryAction = UIAlertAction(title: "Escolher da galeria", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let libraryImagePicker = self.imagePicker(sourceType: .photoLibrary)
            libraryImagePicker.delegate = self
            self.controller?.present(libraryImagePicker, animated: true)
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertVC.addAction(cameraAction)
        alertVC.addAction(libraryAction)
        alertVC.addAction(cancelAction)

        self.controller?.present(alertVC, animated: true, completion: nil)
    }

    private func setupConstraints() {
        addSubview(contentStackView)
        setupTextFieldConstraints()
        setupFoodSelectorConstraints()
        setupImagePickerConstraints()
        setupLabelsConstraints()

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }

    private func setupTextFieldConstraints() {
        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameTextField.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func setupFoodSelectorConstraints() {
        foodSelector.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            foodSelector.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            foodSelector.heightAnchor.constraint(equalTo: foodSelector.widthAnchor, multiplier: 0.233)
        ])
    }

    private func setupImagePickerConstraints() {
        customImagePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customImagePicker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }

    private func setupLabelsConstraints() {
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        foodSelectorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            photoLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            foodSelectorLabel.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
    
    func shakeFoodSelected() {
        foodSelector.shakeEffect(horizontaly: 4)
    }
}

extension ProfileScene: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.customImagePicker.setNewPhoto(image: image)
        self.profileModel?.icon = image.pngData()
        self.controller?.dismiss(animated: true, completion: nil)
    }
}

extension ProfileScene: SelectPhotoDelegate {
    func didTapSelectPhoto() {
        showImagePickerOptions()
    }
}

extension ProfileScene: ProfileSceneDelegate {
    func setController(controller: ProfileViewController) {
        self.controller = controller
    }

    func setupDatas() {
        self.controller?.fetchUser()
        self.controller?.fetchFood()
    }

    func setUser(user: User?) {
        guard let name = user?.name else { return }
        self.profileModel = ProfileModel(name: name, icon: user?.icon)
        self.nameTextField.setPlaceHolder(userName: name)

        if let imageData = user?.icon {
            self.customImagePicker.setNewPhoto(image: UIImage(data: imageData) ?? UIImage())
        } else {
            self.customImagePicker.setNewPhoto(image: UIImage(systemName: "person.crop.circle.fill") ?? UIImage())
        }
    }

    func updatedImage() -> Data? {
        return self.profileModel?.icon
    }

    func getTextFieldName() -> String {
        if self.nameTextField.getnameTextField().isEmpty {
            if let profileModel = profileModel {
                return profileModel.name
            }
        }
        return self.nameTextField.getnameTextField()
    }

    func setSelectedFood(selectedFood: [String]) {
        self.foodSelector.setSelected(selectedFood: selectedFood)
    }

    func getSelectedFood() -> [String] {
        return self.foodSelector.getSelected()
    }
}
