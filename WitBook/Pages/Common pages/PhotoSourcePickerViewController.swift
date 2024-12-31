//
//  PhotoSourcePickerViewController.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//

import UIKit

protocol PhotoSourcePickerDelegate: AnyObject {

    func photoSourcePicker(_ picker: PhotoSourcePickerViewController, didSelect source: UIImagePickerController.SourceType)
}

class PhotoSourcePickerViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let buttonsStackView = UIStackView()
    private let fromLibraryButton = BaseButton()
    private let fromCameraButton = BaseButton()
    
    weak var delegate: PhotoSourcePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        stylize()
        setLayoutConstraints()
        setActions()
    }
        
    private func addSubviews() {
        buttonsStackView.addArrangedSubview(fromLibraryButton)
        buttonsStackView.addArrangedSubview(fromCameraButton)
        
        view.addSubviews(
            titleLabel,
            buttonsStackView
        )
    }
    
    private func stylize() {
        view.backgroundColor = .white
        
        titleLabel.textAlignment = .center
        titleLabel.font = .semibold16
        titleLabel.text = "photo_source_picker.title".localized
        titleLabel.textColor = BaseColor.primary400
        
        fromLibraryButton.title = "photo_source_picker.from_library".localized
        fromCameraButton.title = "photo_source_picker.from_camera".localized
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 16
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
    }
    
    private func setLayoutConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            fromLibraryButton.heightAnchor.constraint(equalToConstant: 48),
            fromCameraButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setActions() {
        fromLibraryButton.addTarget(self, action: #selector(libraryButtonTapped), for: .touchUpInside)
        fromCameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    @objc private func libraryButtonTapped() {
        delegate?.photoSourcePicker(self, didSelect: .photoLibrary)
    }
    
    @objc private func cameraButtonTapped() {
        delegate?.photoSourcePicker(self, didSelect: .camera)
    }
}
