// AlertPresentableDelegate.swift
// Created by Anastasiya Kudasheva

import UIKit

protocol AlertPresentableDelegate: AnyObject {
	func present(alert: UIAlertController, animated flag: Bool)
}
