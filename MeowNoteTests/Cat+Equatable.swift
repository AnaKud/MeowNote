// Cat+Equatable.swift
// Created by Anastasiya Kudasheva

@testable import MeowNote

extension Cat: Equatable {
	public static func == (lhs: Cat, rhs: Cat) -> Bool {
		return lhs.note == rhs.note && lhs.name == rhs.name
	}
}
