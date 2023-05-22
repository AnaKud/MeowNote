// AlertPresenter.swift
// Created by Anastasiya Kudasheva

import UIKit

// 1 способ - через инициациализатор
protocol AlertPresenterProtocol: AnyObject {
	func showAlert(name: String?, note: String?, completion: ((CatNote) -> Void)?)
}

class AlertPresenterWithInializatorInjection: AlertPresenterProtocol {
	weak var delegate: AlertPresentableDelegate?

	init(delegate: AlertPresentableDelegate?) {
		self.delegate = delegate
	}

	func showAlert(name: String?, note: String?, completion: ((CatNote) -> Void)?) {
		let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
		alert.addTextField { textField in
			textField.text = name
			textField.placeholder = "Имя"
		}
		alert.addTextField { textField in
			textField.text = note
			textField.placeholder = "Заметка"
		}
		alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
		alert.addAction(UIAlertAction(title: "Coхранить", style: .default) { _ in
			completion?(CatNote(name: alert.textFields?[0].text,
								note: alert.textFields?[1].text))
		})

		delegate?.present(alert: alert, animated: true)
	}
}

// 2 способ - через метод (didLoad)
protocol AlertPresenterProtocolWithInjectionInFunc: AlertPresenterProtocol {
	func didLoad(_ delegate: AlertPresentableDelegate?)
}

class AlertPresenterWithInjectionInFunc: AlertPresenterProtocolWithInjectionInFunc {
	weak var delegate: AlertPresentableDelegate?

	init() { }

	func didLoad(_ delegate: AlertPresentableDelegate?) {
		self.delegate = delegate
	}

	func showAlert(name: String?, note: String?, completion: ((CatNote) -> Void)?) {
		let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
		alert.addTextField { textField in
			textField.text = name
			textField.placeholder = "Имя"
		}
		alert.addTextField { textField in
			textField.text = note
			textField.placeholder = "Заметка"
		}
		alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
		alert.addAction(UIAlertAction(title: "Coхранить", style: .default) { _ in
			completion?(CatNote(name: alert.textFields?[0].text,
								note: alert.textFields?[1].text))
		})

		delegate?.present(alert: alert, animated: true)
	}
}

// 3 способ - через свойство
protocol AlertPresenterProperty: AnyObject {
	var delegate: AlertPresentableDelegate? { get set }
	func showAlert(name: String?, note: String?, completion: ((CatNote) -> Void)?)
}

class AlertPresenter {
	weak var delegate: AlertPresentableDelegate?

	func showAlert(name: String?, note: String?, completion: ((CatNote) -> Void)?) {
		let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
		alert.addTextField { textField in
			textField.text = name
			textField.placeholder = "Имя"
		}
		alert.addTextField { textField in
			textField.text = note
			textField.placeholder = "Заметка"
		}
		alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
		alert.addAction(UIAlertAction(title: "Coхранить", style: .default) { _ in
			completion?(CatNote(name: alert.textFields?[0].text,
								note: alert.textFields?[1].text))
		})

		delegate?.present(alert: alert, animated: true)
	}
}
