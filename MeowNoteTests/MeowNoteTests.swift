// MeowNoteTests.swift
// Created by Anastasiya Kudasheva

import XCTest
@testable import MeowNote

final class MeowNoteTests: XCTestCase {
	func testPresenter_removeButtonDidTapped_databaseIsEmptyAndButtonNotVisible() {
		let catMock = Cat(name: "mockName", note: "mockNote")

		let vcMock = ViewControllerMock(leftBarButtonVisible: true)
		let dbMock = CatDatabaseManagerMock(cat: catMock)
		let alertMock = AlertPresenterMock()

		let sut = Presenter(vc: vcMock,
							catDataBase: dbMock,
							alertPresenter: alertMock)
		XCTAssertEqual(catMock, dbMock.cat)
		XCTAssertEqual(vcMock.leftBarButtonVisible, true)

		sut.removeButtonDidTapped()

		XCTAssertNil(dbMock.cat)
		XCTAssertEqual(vcMock.leftBarButtonVisible, false)
	}

	func testPresenter_vcWillAppear_labelsAreReloaded() {
		let vcMock = ViewControllerMock(leftBarButtonVisible: true)
		let dbMock = CatDatabaseManagerMock()
		let alertMock = AlertPresenterMock()

		let sut = Presenter(vc: vcMock,
							catDataBase: dbMock,
							alertPresenter: alertMock)
		XCTAssertEqual(vcMock.labelsReloaded, false)
		sut.vcWillAppear()
		XCTAssertEqual(vcMock.labelsReloaded, true)
	}

	func testPresenterPresentAlert() {
		let vcMock = ViewControllerMock()
		let dbMock = CatDatabaseManagerMock()
		let alertMock = AlertPresenterMock()

		let sut = Presenter(vc: vcMock,
							catDataBase: dbMock,
							alertPresenter: alertMock)
		XCTAssertEqual(alertMock.alertIsShown, false)
		let catExpectation = Cat(name: "Cat")
		sut.presentAlert(with: catExpectation)
		XCTAssertEqual(alertMock.alertIsShown, true)
	}
}
