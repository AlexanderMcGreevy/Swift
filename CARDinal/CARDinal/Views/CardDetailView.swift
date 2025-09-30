//  CardDetailView.swift
//  CARDinal
//
//  Detail view for a single (received) business card with actionable links.
//
//  Created by AI Assistant on 9/30/25.

import SwiftUI

struct CardDetailView: View {
    let card: BusinessCard
    @Environment(\.openURL) private var openURL

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                GlassCardView(card: card)
                    .padding(.top, 32)
                actionSection
                contactSection
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
        }
        .background(LinearGradient(colors: [Color.black, Color(white: 0.12)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
        .navigationTitle(card.fullName)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var actionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let website = card.website {
                Button { openURL(website) } label: {
                    Label("Open Website", systemImage: "globe")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(card.accentColor)
            }
            HStack {
                if let ig = card.instagram, !ig.isEmpty, let url = URL(string: "https://instagram.com/\(ig)") {
                    Button { openURL(url) } label: { Label("Instagram", systemImage: "camera") }
                        .buttonStyle(.bordered)
                }
                if let li = card.linkedIn, !li.isEmpty, let url = URL(string: "https://linkedin.com/in/\(li)") {
                    Button { openURL(url) } label: { Label("LinkedIn", systemImage: "link") }
                        .buttonStyle(.bordered)
                }
            }
        }
    }

    private var contactSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let phone = card.phone, !phone.isEmpty {
                let digits = phone.filter { $0.isNumber }
                if let telURL = URL(string: "tel://" + digits) {
                    Button { openURL(telURL) } label: { Label(phone, systemImage: "phone") }
                        .buttonStyle(.plain)
                        .foregroundStyle(.primary)
                }
            }
            if let email = card.email, !email.isEmpty, let mailURL = URL(string: "mailto:" + email) {
                Button { openURL(mailURL) } label: { Label(email, systemImage: "envelope") }
                    .buttonStyle(.plain)
                    .foregroundStyle(.primary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(.white.opacity(0.08)))
    }
}

#Preview {
    NavigationStack { CardDetailView(card: BusinessCard(fullName: "Jane Doe", company: "Acme", role: "Engineer", website: URL(string: "https://acme.com"), instagram: "janedoe", linkedIn: "janedoe", phone: "5551234", email: "jane@acme.com", accentColor: .purple)) }
}
