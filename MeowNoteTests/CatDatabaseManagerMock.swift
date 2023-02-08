// CatDatabaseManagerMock.swift
// Created by Anastasiya Kudasheva

@testable import MeowNote

class CatDatabaseManagerMock: CatDatabaseManagerProtocol {
	private(set) var cat: Cat?

	init(cat: Cat = Cat()) {
		self.cat = cat
	}

	func createNote(_ cat: Cat) {
		self.cat = cat
	}

	func readNote() -> Cat {
		return self.cat ?? Cat()
	}

	func delete() {
		self.cat = nil
	}
}
