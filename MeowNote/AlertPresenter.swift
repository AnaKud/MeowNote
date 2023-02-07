// AlertPresenter.swift
// Created by Anastasiya Kudasheva

import UIKit
import AccessibilityIds

protocol AlertPresenterProtocol: AnyObject {
	func didLoad(_ vc: UIViewController)
	func showAlert(for noteViewModel: NoteViewModel)
}

class AlertPresenter: AlertPresenterProtocol {
	private weak var viewController: UIViewController?

	func didLoad(_ vc: UIViewController) {
		self.viewController = vc
	}

	func showAlert(for noteViewModel: NoteViewModel) {
		let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
		alert.addTextField { textField in
			textField.text = noteViewModel.title
			textField.placeholder = "Имя"
			textField.accessibilityIdentifier = AccessibilityIds.Alert.nameTF
		}
		alert.addTextField { textField in
			textField.text = noteViewModel.text
			textField.placeholder = "Заметка"
			textField.accessibilityIdentifier = AccessibilityIds.Alert.noteTF
		}
		alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
		alert.addAction(UIAlertAction(title: "Coхранить", style: .default) { _ in
			noteViewModel.handler(Note(title: alert.textFields?[0].text,
									   text: alert.textFields?[1].text))
		})
		alert.view.accessibilityIdentifier = AccessibilityIds.Alert.view
		self.viewController?.present(alert, animated: true)
	}
}
