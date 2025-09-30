//  CardStore.swift
//  CARDinal
//
//  Holds user's card and received cards. Provides encode/decode for QR sharing.
//
//  Created by AI Assistant on 9/30/25.

import Foundation
import SwiftUI
import Combine

@MainActor
final class CardStore: ObservableObject {
    @Published var myCard: BusinessCard
    @Published var received: [BusinessCard] = []

    private let myCardKey = "myCard.json"
    private let receivedKey = "received.json"

    init() {
        if let saved: BusinessCard = Self.load(myCardKey) {
            myCard = saved
        } else {
            myCard = BusinessCard(fullName: "Your Name", company: "Company", role: "Role", website: nil, instagram: nil, linkedIn: nil, phone: nil, email: nil, accentColor: .cyan)
        }
        if let saved: [BusinessCard] = Self.load(receivedKey) { received = saved }
    }

    func updateMyCard(_ update: (inout BusinessCard) -> Void) {
        update(&myCard)
        persist()
    }

    func addReceived(from qrString: String) throws {
        let data = Data(qrString.utf8)
        let decoded = try JSONDecoder().decode(BusinessCard.self, from: data)
        guard decoded.id != myCard.id else { return } // ignore own
        if !received.contains(decoded) {
            received.insert(decoded, at: 0)
            persist()
        }
    }

    func qrPayload() throws -> String {
        let data = try JSONEncoder().encode(myCard)
        return String(decoding: data, as: UTF8.self)
    }

    private func persist() {
        Self.save(myCard, key: myCardKey)
        Self.save(received, key: receivedKey)
    }
}

private extension CardStore {
    static func save<T: Encodable>(_ value: T, key: String) {
        do { let data = try JSONEncoder().encode(value); UserDefaults.standard.set(data, forKey: key) } catch { print("Save error: \(error)") }
    }
    static func load<T: Decodable>(_ key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
