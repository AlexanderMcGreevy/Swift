//  BusinessCard.swift
//  CARDinal
//
//  Model representing a single business card.
//
//  Created by AI Assistant on 9/30/25.

import Foundation
import SwiftUI

struct BusinessCard: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var fullName: String
    var company: String
    var role: String
    var website: URL?
    var instagram: String?
    var linkedIn: String?
    var phone: String?
    var email: String?
    var accentColorHex: String?
    var createdAt: Date = Date()

    init(id: UUID = UUID(), fullName: String = "", company: String = "", role: String = "", website: URL? = nil, instagram: String? = nil, linkedIn: String? = nil, phone: String? = nil, email: String? = nil, accentColor: Color? = nil) {
        self.id = id
        self.fullName = fullName
        self.company = company
        self.role = role
        self.website = website
        self.instagram = instagram
        self.linkedIn = linkedIn
        self.phone = phone
        self.email = email
        if let accentColor = accentColor { self.accentColorHex = accentColor.toHex() }
    }
}

extension BusinessCard {
    var accentColor: Color { Color.fromHex(accentColorHex) ?? .cyan }
}

// MARK: - Color <-> Hex helpers
extension Color {
    func toHex() -> String? {
        #if canImport(UIKit)
        let ui = UIColor(self)
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard ui.getRed(&r, green: &g, blue: &b, alpha: &a) else { return nil }
        return String(format: "#%02X%02X%02X", Int(r*255), Int(g*255), Int(b*255))
        #else
        return nil
        #endif
    }

    static func fromHex(_ hex: String?) -> Color? {
        guard let hex = hex else { return nil }
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cleaned.hasPrefix("#") { cleaned.removeFirst() }
        guard cleaned.count == 6, let value = Int(cleaned, radix: 16) else { return nil }
        let r = Double((value >> 16) & 0xFF) / 255.0
        let g = Double((value >> 8) & 0xFF) / 255.0
        let b = Double(value & 0xFF) / 255.0
        return Color(red: r, green: g, blue: b)
    }
}
