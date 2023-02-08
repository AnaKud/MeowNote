// SceneDelegate.swift
// Created by Anastasiya Kudasheva

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene,
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		self.changeStateForUITesting()
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let viewController = ViewController()
		window.rootViewController = UINavigationController(rootViewController: viewController)
		self.window = window
		window.makeKeyAndVisible()
	}

	private func changeStateForUITesting() {
		if ProcessInfo().arguments.contains("deleteNote") {
			self.deleteNote()
		}
		if ProcessInfo().arguments.contains("setNote") {
			self.setNote()
		}
	}
}

extension SceneDelegate {
	private static let dataBaseManager: DatabaseManagerTestProtocol = CatDatabaseManager()

	func setNote() {
		Self.dataBaseManager.createNote(Cat(name: "Барсик",
											note: "Барсик милаш"))
	}

	func deleteNote() {
		Self.dataBaseManager.delete()
	}
}
