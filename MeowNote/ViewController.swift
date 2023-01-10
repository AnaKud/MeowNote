// ViewController.swift
// Created by Anastasiya Kudasheva

import UIKit

class ViewController: UIViewController {
	private var alerPresenter: AlertPresenterProtocol?
	private let catDataBase: CatDatabaseMangerProtocol = CatDatabaseManger()

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
		return label
	}()

	private let catNameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana", size: 20)
		return label
	}()

	private let noteLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = UIFont(name: "Verdana Bold", size: 24)
		label.text = "Заметка о коте:"
		return label
	}()

	private let catNoteLabel: UILabel = {
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
		self.alerPresenter = AlertPresenter()
		self.alerPresenter?.didLoad(self)

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

		self.reloadLabels()
		self.changeLeftBarButtonVisabilty()
	}
}

private extension ViewController {
	func presentAlert(with cat: Cat) {
		self.alerPresenter?.showAlert(for: NoteViewModel(title: cat.name,
														 text: cat.note,
														 handler: { [weak self] note in
			guard let self else { return }
			self.catDataBase.createNote(Cat(name: note.title, note: note.text))
			self.reloadLabels()
			self.changeLeftBarButtonVisabilty()
		}))
	}

	func changeLeftBarButtonVisabilty() {
		if self.catNameLabel.text == nil &&
			self.catNoteLabel.text == nil {
			self.navigationItem.leftBarButtonItem?.image = nil
		} else {
			self.navigationItem.leftBarButtonItem?.image = UIImage(systemName: "trash")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
		}
	}

	func reloadLabels() {
		let cat = self.catDataBase.readNote()
		self.catNameLabel.text = cat.name
		self.catNoteLabel.text = cat.note
	}
}

// MARK: - Действия по тапу на кнопки
@objc
private extension ViewController {
	func addButtonDidTapped() {
		self.presentAlert(with: Cat(name: self.catNameLabel.text,
									note: self.catNoteLabel.text))
	}

	func removeButtonDidTapped() {
		self.catDataBase.delete()
		self.reloadLabels()
		self.changeLeftBarButtonVisabilty()
	}
}
