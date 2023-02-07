// Presenter.swift
// Created by Anastasiya Kudasheva

import Foundation

protocol PresenterProtocol: AnyObject {
	func vcWillAppear()
	func presentAlert(with cat: Cat)
	func removeButtonDidTapped()
}

class Presenter: PresenterProtocol {
	private var alertPresenter: AlertPresenterProtocol?
	private let catDataBase: CatDatabaseManagerProtocol = CatDatabaseManager()
	private weak var vc: ViewControllerProtocol?

	init(vc: ViewControllerProtocol?) {
		self.vc = vc
		self.alertPresenter = AlertPresenter()
	}

	func vcWillAppear() {
		self.reloadLabels()
		self.alertPresenter?.didLoad(self.vc)
	}

	func presentAlert(with cat: Cat) {
		self.alertPresenter?.showAlert(for: NoteViewModel(title: cat.name,
														  text: cat.note,
														  handler: { [weak self] note in
			guard let self else { return }
			self.catDataBase.createNote(Cat(name: note.title, note: note.text))

			self.reloadLabels()
		}))
	}

	func removeButtonDidTapped() {
		self.catDataBase.delete()
		self.reloadLabels()
	}

	private func reloadLabels() {
		let cat = self.catDataBase.readNote()
		self.vc?.reloadLabels(with: cat)
		self.changeLeftBarButtonVisibility()
	}

	private func changeLeftBarButtonVisibility() {
		let cat = self.catDataBase.readNote()
		if cat.name == nil &&
			cat.note == nil {
			self.vc?.changeLeftBarButtonVisibility(false)
		} else {
			self.vc?.changeLeftBarButtonVisibility(true)
		}
	}
}
