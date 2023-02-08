// DatabaseManager.swift
// Created by Anastasiya Kudasheva

import Foundation

protocol DatabaseManagerTestProtocol: AnyObject {
	func createNote(_ cat: Cat)
	func delete()
}

protocol CatDatabaseManagerProtocol: DatabaseManagerTestProtocol {
	func createNote(_ cat: Cat)
	func readNote() -> Cat
	func delete()
}

class CatDatabaseManager: CatDatabaseManagerProtocol {
	private let catKey = "Cat"

	func createNote(_ cat: Cat) {
		let encoder = JSONEncoder()
		if let data = try? encoder.encode(cat) {
			UserDefaults.standard.set(data, forKey: self.catKey)
		}
	}

	func readNote() -> Cat {
		let decoder = JSONDecoder()
		if let userDefaultsData = UserDefaults.standard.object(forKey: self.catKey) as? Data,
		   let cat = try? decoder.decode(Cat.self, from: userDefaultsData) {
			return cat
		}
		else {
			return Cat()
		}
	}

	func delete() {
		UserDefaults.standard.removeObject(forKey: self.catKey)
	}
}
