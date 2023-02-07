// MeowNoteUITests.swift
// Created by Anastasiya Kudasheva

import XCTest
import AccessibilityIds

final class MeowNoteUITests: XCTestCase {
/*
 ТК-3
 Цель: проверка отображения UI-элементов, если пользователь хотел добавить заметку, но передумал
 */
	func testUserAddNoteThenForget() {
		let app = XCUIApplication()
		app.launch()
		app.buttons[AccessibilityIds.VC.rightBarButtonItem].tap()
		let alert = app.alerts[AccessibilityIds.Alert.view]
		XCTAssertTrue(alert.exists)
		XCTAssertEqual(alert.label, "Добавить")
		let nameTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.nameTF]
		nameTextField.tap()
		nameTextField.typeText("Имя")
		let noteTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.noteTF]
		noteTextField.tap()
		noteTextField.typeText("Заметка")
		alert.scrollViews.otherElements.buttons["Отмена"].tap()
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].exists, false)
	}
}
