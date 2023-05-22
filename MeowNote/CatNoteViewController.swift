// CatNoteViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class CatNoteViewController: UIViewController, AlertPresentableDelegate {
	/* 1 способ через инициализатор
	 var alertPresenter: AlertPresenterProtocol?
	 */

	/* 2 способ через метод
	 var alertPresenter: AlertPresenterProtocolWithInjectionInFunc?
	 */

	/* 3 способ через свойство*/
	var alertPresenter: AlertPresenter?

	let backgroundImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .catInBread
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	let nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana Bold", size: 24)
		label.text = "Имя кота:"
		return label
	}()

	let catNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana", size: 20)
		return label
	}()

	let noteLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana Bold", size: 24)
		label.text = "Заметка о коте:"
		return label
	}()

	let catNoteLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana", size: 20)
		label.backgroundColor = .lightGray.withAlphaComponent(0.5)
		label.layer.cornerRadius = 12
		label.layer.masksToBounds = true
		return label
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		/* 1 способ через иницилизатор
		 alertPresenter = AlertPresenterWithInializatorInjection(delegate: self)
		 */

		/* 2 способ через метод
		 alertPresenter.didLoad(self)
		 */

		/* 3 способ через свойство*/
		alertPresenter = AlertPresenter()
		alertPresenter?.delegate = self

		let plusImage = UIImage(systemName: "plus")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		let rightBarButtonItem = UIBarButtonItem(image: plusImage,
												 style: .done,
												 target: self,
												 action: #selector(self.addButtonDidTapped))
		self.navigationItem.rightBarButtonItem = rightBarButtonItem

		let trashImage = UIImage(systemName: "trash")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		let leftBarButtonItem = UIBarButtonItem(image: trashImage,
												style: .plain,
												target: self,
												action: #selector(self.removeButtonDidTapped))
		self.navigationItem.leftBarButtonItem = leftBarButtonItem

		self.navigationController?.navigationBar.prefersLargeTitles = true
		self.navigationController?.navigationBar.topItem?.title = "Котозаметки"
	}

	// Установка вью
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		// Делаем стэквью
		let horisontalNameStack = UIStackView(arrangedSubviews: [self.nameLabel, self.catNameLabel])
		horisontalNameStack.spacing = 24

		let verticalNoteStack = UIStackView(arrangedSubviews: [self.noteLabel, self.catNoteLabel])
		verticalNoteStack.axis = .vertical

		let verticalStack = UIStackView(arrangedSubviews: [horisontalNameStack, verticalNoteStack])
		verticalStack.spacing = 24
		verticalStack.axis = .vertical

		// Первый вариант установки констрейнтов вью
		self.view.addSubview(self.backgroundImageView)
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

		// Второй способ установки констрейнтов вью
		self.backgroundImageView.addSubview(verticalStack)
		verticalStack.translatesAutoresizingMaskIntoConstraints = false

		self.view.addConstraints([
			NSLayoutConstraint(item: verticalStack, attribute: .top, relatedBy: .equal, toItem:  self.view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 24),
			NSLayoutConstraint(item: verticalStack, attribute: .leading, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .leading, multiplier: 1, constant: 24),
			NSLayoutConstraint(item: verticalStack, attribute: .trailing, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .trailing, multiplier: 1, constant: -24),
		])
	}

	// Сокрытие кнопки удалить
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.changeLeftBarButtonVisabilty()
	}

	func present(alert: UIAlertController, animated flag: Bool) {
		self.present(alert, animated: flag)
	}

	func presentAlert(name: String?, note: String?) {
		alertPresenter?.showAlert(name: name, note: note, completion: { [weak self] catNote in
			self?.saveNote(name: catNote.name,
						  note: catNote.note)
		})
	}

	func saveNote(name: String?, note: String?) {
		print(#function)
		self.catNameLabel.text = name
		self.catNoteLabel.text = note
		self.changeLeftBarButtonVisabilty()
	}

	func removeNote() {
		print(#function)
		self.catNameLabel.text = nil
		self.catNoteLabel.text = nil

		self.changeLeftBarButtonVisabilty()
	}

	func changeLeftBarButtonVisabilty() {
		if self.catNameLabel.text == nil &&
			self.catNoteLabel.text == nil {
			self.navigationItem.leftBarButtonItem?.image = nil
		} else {
			self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "trash")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		}
	}
}

// MARK: - Действия по тапу на кнопки
@objc
extension CatNoteViewController {
	func addButtonDidTapped() {
		self.presentAlert(name: self.catNameLabel.text,
						  note: self.catNoteLabel.text)
	}

	func removeButtonDidTapped() {
		self.removeNote()
	}
}
