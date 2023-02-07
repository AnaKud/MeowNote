// AlertPresentable.swift
// Created by Anastasiya Kudasheva

import UIKit

protocol AlertPresenterDelegate: AnyObject {
	func present(alert: UIAlertController, animated: Bool)
}

extension UIViewController: AlertPresenterDelegate {
	func present(alert: UIAlertController, animated: Bool) {
		self.present(alert, animated: animated)
	}
}
