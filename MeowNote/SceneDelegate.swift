// SceneDelegate.swift
// Created by Anastasiya Kudasheva

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		let viewController = ViewController()
		window.rootViewController = UINavigationController(rootViewController: viewController)
		self.window = window
		window.makeKeyAndVisible()
	}
}
