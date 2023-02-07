// MeowNoteTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import MeowNote

class ViewControllerMock: ViewControllerProtocol {
	private(set) var leftBarButtonVisible: Bool = true
	private(set) var alertIsShown: Bool = false

	func changeLeftBarButtonVisibility(_ isVisible: Bool) {
		self.leftBarButtonVisible = isVisible
	}

	func reloadLabels(with cat: MeowNote.Cat) {
	}

	func present(alert: UIAlertController, animated: Bool) {
		self.alertIsShown = true
	}
}

final class MeowNoteTests: XCTestCase {
	func testPresenter() {
		let mock = ViewControllerMock()
		let sut = Presenter(vc: mock)
		XCTAssertEqual(mock.leftBarButtonVisible, true)
		sut.removeButtonDidTapped()
		XCTAssertEqual(mock.leftBarButtonVisible, false)
	}

	func testPresenter1() {
		let mock = ViewControllerMock()
		let sut = Presenter(vc: mock)
		XCTAssertEqual(mock.alertIsShown, false)
		let catExpectation = Cat(name: "Cat")
		sut.presentAlert(with: catExpectation)
		XCTAssertEqual(mock.alertIsShown, false)
	}
}
