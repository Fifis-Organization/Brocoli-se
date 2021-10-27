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

    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Foto"
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private lazy var customImagePicker: CustomImagePicker = CustomImagePicker(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height*0.25))

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private let nameTextField: TextField = TextField()

    private lazy var foodSelectorLabel: UILabel = {
        let label = UILabel()
        label.text = "Selecione os alimentos não consumidos"
        label.numberOfLines = 0
        label.font = self.frame.height > 667 ? .graviolaSoft(size: 20) : .graviolaSoft(size: 17)
        label.textColor = .blueDark
        return label
    }()
    private let foodSelector: FoodSelectorComponent = FoodSelectorComponent()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [photoLabel, customImagePicker, nameLabel, nameTextField, foodSelectorLabel, foodSelector, spacer])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20.0
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
            frame.origin.y -= (self.isActiveKeyboard ? 0 : 80)
            isActiveKeyboard = true
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        frame.origin.y += (self.isActiveKeyboard ? 80 : 0)
        isActiveKeyboard = false
        nameTextField.dismissKeyborad()
    }

    private func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }

    private func showImagePickerOptions() {
        let alertVC = UIAlertController(title: "Escolha uma foto", message: "Camera ou Galeria", preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard let self = self else {
                return
            }
            let cameraImagePicker = self.imagePicker(sourceType: .camera)
            cameraImagePicker.delegate = self
            self.controller?.present(cameraImagePicker, animated: true)
        }

        let libraryAction = UIAlertAction(title: "Galeria", style: .default) { [weak self] _ in
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

    func getTextFieldName() -> String {
        return nameTextField.getnameTextField()
    }

    private func setupConstraints() {
        addSubview(contentStackView)
        setupTextFieldConstraints()
        setupFoodSelectorConstraints()
        setupImagePickerConstraints()

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
            nameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupFoodSelectorConstraints() {
        foodSelector.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            foodSelector.widthAnchor.constraint(equalTo: contentStackView.widthAnchor),
            foodSelector.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }

    private func setupImagePickerConstraints() {
        customImagePicker.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            customImagePicker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor)
        ])
    }
}

extension ProfileScene: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        self.customImagePicker.setNewPhoto(image: image)
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

    func setUser(user: User?) {
        
    }

    func setupDatas() {
        self.controller?.fetchUser()
    }
}
