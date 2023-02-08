// AlertPresenterMock.swift
// Created by Anastasiya Kudasheva

@testable import MeowNote

class AlertPresenterMock: AlertPresenterProtocol {
	private(set) var alertIsShown: Bool = false

	func showAlert(for noteViewModel: NoteViewModel) {
		self.alertIsShown = true
	}
}
