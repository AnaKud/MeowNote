// XCUIApplication+UserDefaults in launch.swift
// Created by Anastasiya Kudasheva

import XCTest

extension XCUIApplication {
	func setNote() {
		self.launchArguments += ["setNote"]
	}

	func deleteNote() {
		self.launchArguments += ["deleteNote"]
	}
}
