// ViewControllerMock.swift
// Created by Anastasiya Kudasheva

@testable import MeowNote

class ViewControllerMock: ViewControllerProtocol {
	private(set) var leftBarButtonVisible: Bool
	private(set) var labelsReloaded: Bool = false

	init(leftBarButtonVisible: Bool = false) {
		self.leftBarButtonVisible = leftBarButtonVisible
	}

	func changeLeftBarButtonVisibility(_ isVisible: Bool) {
		self.leftBarButtonVisible = isVisible
	}

	func reloadLabels(with cat: Cat) {
		self.labelsReloaded = true
	}
}
