// MeowNoteUITests.swift
// Created by Anastasiya Kudasheva

import XCTest
import AccessibilityIds

final class MeowNoteUITests: XCTestCase {
	/* ТК-1
	Цель: проверка отображения UI-элементов, если нет сохраненной заметки
	*/
	func testCheckControlsIfNoSavedNote() {
		let app = XCUIApplication()
		app.deleteNote()
		app.launch()
		XCTAssertTrue(app.navigationBars[AccessibilityIds.VC.navigationBar].staticTexts["Котозаметки"].exists)

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.nameLabel].label, "Имя кота:")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.noteLabel].label, "Заметка о коте:")

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].exists, false)

		XCTAssertTrue(app.buttons[AccessibilityIds.VC.rightBarButtonItem].exists)
		XCTAssertFalse(app.buttons[AccessibilityIds.VC.leftBarButtonItem].exists)
	}
	/* ТК-2
	Цель: проверка отображения UI-элементов алерта, если нет сохраненных заметок
	*/
	func testAlertControls() {
		let app = XCUIApplication()
		app.deleteNote()
		app.launch()

		app.buttons[AccessibilityIds.VC.rightBarButtonItem].tap()
		sleep(1)
		let alert = app.alerts[AccessibilityIds.Alert.view]
		XCTAssertTrue(alert.exists)

		XCTAssertEqual(alert.label, "Добавить")

		let nameTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.nameTF]
		XCTAssertTrue(nameTextField.exists)
		XCTAssertEqual(nameTextField.placeholderValue, "Имя")

		let noteTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.noteTF]
		XCTAssertTrue(noteTextField.exists)
		XCTAssertEqual(noteTextField.placeholderValue, "Заметка")
	}

	/* ТК-3
	 Цель: проверка отображения UI-элементов, если пользователь хотел добавить заметку, но передумал
	 */
	func testUserAddNoteThenForget() {
		let app = XCUIApplication()
		app.launch()
		app.deleteNote()
		app.buttons[AccessibilityIds.VC.rightBarButtonItem].tap()
		sleep(1)
		let alert = app.alerts[AccessibilityIds.Alert.view]
		let nameTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.nameTF]
		nameTextField.tap()
		nameTextField.typeText("Имя")

		let noteTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.noteTF]
		noteTextField.tap()
		noteTextField.typeText("Заметка")

		alert.scrollViews.otherElements.buttons["Отмена"].tap()
		sleep(1)
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].exists, false)
	}

	/* ТК-4
	Цель: проверка отображения UI-элементов, если пользователь добавил заметку
	*/
	func testUserAddNoteThenSave() {
		let app = XCUIApplication()
		app.deleteNote()
		app.launch()
		app.buttons[AccessibilityIds.VC.rightBarButtonItem].tap()
		sleep(1)
		let alert = app.alerts[AccessibilityIds.Alert.view]
		let nameTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.nameTF]
		nameTextField.tap()
		nameTextField.typeText("Имя")

		let noteTextField = alert.collectionViews.textFields[AccessibilityIds.Alert.noteTF]
		noteTextField.tap()
		noteTextField.typeText("Заметка")

		alert.scrollViews.otherElements.buttons["Сохранить"].tap()
		sleep(1)
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "Имя")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].label, "Заметка")

		XCTAssertTrue(app.buttons[AccessibilityIds.VC.leftBarButtonItem].exists)
	}

	/* ТК-5
	Цель: проверка отображения UI-элементов, если пользователь удалил существующую заметку
	 Предусловия:
	 У пользователя есть сохраненная заметка
	 Пользователь открыл приложение
	 Проверки:
	 На экране отображаются название полей - Имя, заметка
	 Поле «имя» содержит имя
	 Поле «заметка» содержит заметку
	 Нажать на кнопку удалить в левом верхнем углу
	 Поле «имя» пустое
	 Поле «заметка» пустое
	 В правом верхнем углу кнопка плюс
	 В левом верхнем углу отсутствует кнопка корзина
	 */
	func testControlIfUserAlreadyHasNoteThenDelete() {
		let app = XCUIApplication()
		app.deleteNote()
		app.setNote()
		app.launch()

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.nameLabel].label, "Имя кота:")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.noteLabel].label, "Заметка о коте:")

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "Барсик")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].label, "Барсик милаш")

		XCTAssertTrue(app.buttons[AccessibilityIds.VC.rightBarButtonItem].exists)
		XCTAssertTrue(app.buttons[AccessibilityIds.VC.leftBarButtonItem].exists)

		app.buttons[AccessibilityIds.VC.leftBarButtonItem].tap()
		sleep(1)

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].exists, false)

		XCTAssertTrue(app.buttons[AccessibilityIds.VC.rightBarButtonItem].exists)
		XCTAssertFalse(app.buttons[AccessibilityIds.VC.leftBarButtonItem].exists)
	}

	/* ТК-6
	Цель: проверка отображения UI-элементов алерта, если есть сохраненная заметка
	*/
	func testControlIfUserAlreadyHasNote() {
		let app = XCUIApplication()
		app.deleteNote()
		app.setNote()
		app.launch()

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.nameLabel].label, "Имя кота:")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.noteLabel].label, "Заметка о коте:")

		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNameLabel].label, "Барсик")
		XCTAssertEqual(app.staticTexts[AccessibilityIds.VC.catNoteLabel].label, "Барсик милаш")

		app.buttons[AccessibilityIds.VC.rightBarButtonItem].tap()
		sleep(1)

		let alert = app.alerts[AccessibilityIds.Alert.view]

		XCTAssertEqual(alert.collectionViews.textFields[AccessibilityIds.Alert.nameTF].value as? String,
					   "Барсик")

		XCTAssertEqual(alert.collectionViews.textFields[AccessibilityIds.Alert.noteTF].value as? String,
					   "Барсик милаш")
	}
}
