//
//  UpdateProfilePageViewController.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import PhotosUI

class UpdateProfilePageViewController: BaseViewController {

    var interactor: UpdateProfilePageInteractorInput?
    var router: UpdateProfilePageRouterInput?
    
    private let pickerPlacholderView = PickerPlaceholderView()
    private let titleLabel = UILabel()
    private let nameTextField = BaseTextField()
    private let continueButton = BaseButton()
    
    private var continueButtonBottomConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func addSubviews() {
        view.addSubviews(
            pickerPlacholderView,
            titleLabel,
            nameTextField,
            continueButton
        )
    }

    private func setLayoutConstraints() {
    	var layoutConstraints = [NSLayoutConstraint]()
        
        pickerPlacholderView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            pickerPlacholderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 84),
            pickerPlacholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: pickerPlacholderView.bottomAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ]
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ]
        
        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
    	layoutConstraints += [
            continueButtonBottomConstraint,
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    	]

    	NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        view.backgroundColor = .white
        
        pickerPlacholderView.titleText = "update_profile.profile_photo".localized
        pickerPlacholderView.image = BaseImage.ic_add_photo_placeholder.uiImage
        
        titleLabel.text = "update_profile.title".localized
        titleLabel.textAlignment = .left
        titleLabel.font = .medium20
        titleLabel.textColor = BaseColor.primary400
        
        nameTextField.placeholderText = "update_profile.name_placeholder".localized
        
        continueButton.title = "common.continue".localized
    }

    private func setActions() {
        view.addTapGesture { [weak self] in
            self?.view.endEditing(true)
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        nameTextField.addTarget(self, action: #selector(didChangeNameTextField), for: .editingChanged)
        pickerPlacholderView.addTapGesture { [weak self] in
            self?.router?.presentPhotoPickerSourceOptionsBottomSheet()
        }
        continueButton.addTapGesture {
            self.interactor?.didTapContinueButton()
        }
    }
}

extension UpdateProfilePageViewController: UpdateProfilePageViewInput {
    
    func didSelectPickerSource(
        _ picker: PhotoSourcePickerViewController,
        didSelect source: UIImagePickerController.SourceType
    ) {
        picker.dismiss(animated: true) { [weak self] in
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            switch source {
            case .photoLibrary:
                PHPhotoLibrary.requestAuthorization { status in
                    DispatchQueue.main.async {
                        if status == .authorized {
                            imagePicker.sourceType = .photoLibrary
                            self?.present(imagePicker, animated: true)
                        } else {
                            self?.showPhotoOrCameraAccessAlert()
                        }
                    }
                }
            case .camera:
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    DispatchQueue.main.async {
                        if granted {
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                imagePicker.sourceType = .camera
                                self?.present(imagePicker, animated: true)
                            }
                        } else {
                            self?.showPhotoOrCameraAccessAlert()
                        }
                    }
                }
            case .savedPhotosAlbum:
                break
            @unknown default: break
            }
        }
    }
    
    func routeToTabBarPages(commonStore: CommonStore) {
        router?.routeToTabBarPages(commonStore: commonStore)
    }
}

extension UpdateProfilePageViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
          if let selectedImage = info[.originalImage] as? UIImage {
              pickerPlacholderView.image = selectedImage
              interactor?.pass(selectedImage)
          }
          picker.dismiss(animated: true)
    }
}


private extension UpdateProfilePageViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            continueButtonBottomConstraint.constant = -12 - keyboardHeight
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        continueButtonBottomConstraint.constant = -48
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func didChangeNameTextField() {
        interactor?.didChangeNameText(nameTextField.text)
    }
    
    func showPhotoOrCameraAccessAlert() {
        let title = "update_profile.alert_access_title".localized
        let message = "update_profile.alert_access_description".localized
        let action = {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
        showAlert(title: title, message: message, action: action)
    }
}
