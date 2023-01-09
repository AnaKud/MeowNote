// Models.swift
// Created by Anastasiya Kudasheva

import Foundation

struct Cat: Codable {
	var name: String?
	var note: String?
}

struct Note {
	var title: String?
	var text: String?
}

struct NoteViewModel {
	var title: String?
	var text: String?
	var handler: (Note) -> Void
}
