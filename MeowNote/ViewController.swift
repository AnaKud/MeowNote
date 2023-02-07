// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit
import AccessibilityIds

protocol ViewControllerProtocol: AlertPresenterDelegate {
	func changeLeftBarButtonVisibility(_ isVisible: Bool)
	func reloadLabels(with cat: Cat)
}

class ViewController: UIViewController {
	private var presenter: PresenterProtocol?

	private let backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .catInBread
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	private let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana Bold", size: 24)
		label.text = "Имя кота:"
		label.accessibilityIdentifier = AccessibilityIds.VC.nameLabel
		return label
	}()

	private let catNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana", size: 20)
		label.accessibilityIdentifier = AccessibilityIds.VC.catNameLabel
		return label
	}()

	private let noteLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana Bold", size: 24)
		label.text = "Заметка о коте:"
		label.accessibilityIdentifier = AccessibilityIds.VC.noteLabel
		return label
	}()

	private let catNoteLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana", size: 20)
		label.accessibilityIdentifier = AccessibilityIds.VC.catNoteLabel
		return label
	}()

	private lazy var stackView: UIStackView = {
		return self.makeStackView()
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter = Presenter(vc: self)
		self.configureNavigationBar()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.configureBackgroundImageViewConstraints()
		self.backgroundImageView.addSubview(self.stackView)
		self.configureStackViewConstraints()

		self.presenter?.vcWillAppear()
	}
}

// MARK: - Configure UI
private extension ViewController {
	func configureNavigationBar() {
		let plusImage = UIImage(systemName: "plus")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		let rightBarButtonItem = UIBarButtonItem(image: plusImage,
												 style: .done,
												 target: self,
												 action: #selector(self.addButtonDidTapped))
		rightBarButtonItem.accessibilityIdentifier = AccessibilityIds.VC.rightBarButtonItem
		self.navigationItem.rightBarButtonItem = rightBarButtonItem

		let trashImage = UIImage(systemName: "trash")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		let leftBarButtonItem = UIBarButtonItem(image: trashImage,
												style: .plain,
												target: self,
												action: #selector(self.removeButtonDidTapped))
		leftBarButtonItem.accessibilityIdentifier = AccessibilityIds.VC.leftBarButtonItem
		self.navigationItem.leftBarButtonItem = leftBarButtonItem

		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationController?.navigationBar.topItem?.title = "Котозаметки"
		self.navigationController?.navigationBar.accessibilityIdentifier = AccessibilityIds.VC.navigationBar
	}

	func makeStackView() -> UIStackView {
		let horizontalNameStack = UIStackView(arrangedSubviews: [self.nameLabel, self.catNameLabel])
		horizontalNameStack.spacing = 24

		let verticalNoteStack = UIStackView(arrangedSubviews: [self.noteLabel, self.catNoteLabel])
		verticalNoteStack.axis = .vertical
		verticalNoteStack.backgroundColor = .lightGray.withAlphaComponent(0.3)
		verticalNoteStack.layer.cornerRadius = 6
		verticalNoteStack.layer.masksToBounds = true

		verticalNoteStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true

		let verticalStack = UIStackView(arrangedSubviews: [horizontalNameStack, verticalNoteStack])
		verticalStack.spacing = 24
		verticalStack.axis = .vertical
		return verticalStack
	}

	// Первый вариант настройки констрейнтов
	func configureBackgroundImageViewConstraints() {
		self.view.addSubview(self.backgroundImageView)
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
	}

	// Второй вариант настройки констрейнтов
	func configureStackViewConstraints() {
		self.stackView.translatesAutoresizingMaskIntoConstraints = false

		self.view.addConstraints([
			NSLayoutConstraint(item: self.stackView, attribute: .top, relatedBy: .equal, toItem:  self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 24),
			NSLayoutConstraint(item: self.stackView, attribute: .leading, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .leading, multiplier: 1, constant: 24),
			NSLayoutConstraint(item: self.stackView, attribute: .trailing, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .trailing, multiplier: 1, constant: -24),
		])
	}
}

// MARK: - UI Changing
extension ViewController: ViewControllerProtocol {
	func changeLeftBarButtonVisibility(_ isVisible: Bool) {
		if isVisible {
			self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "trash")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		} else {
			self.navigationItem.leftBarButtonItem?.image = nil
		}
	}

	func reloadLabels(with cat: Cat) {
		self.catNameLabel.text = cat.name
		self.catNoteLabel.text = cat.note
	}
}

// MARK: - Действия по тапу на кнопки
@objc
private extension ViewController {
	func addButtonDidTapped() {
		self.presenter?.presentAlert(with: Cat(name: self.catNameLabel.text,
											   note: self.catNoteLabel.text))
	}

	func removeButtonDidTapped() {
		self.presenter?.removeButtonDidTapped()
	}
}
