//  GlassCardView.swift
//  CARDinal
//
//  A reusable glass / liquid glass style business card view.
//
//  Created by AI Assistant on 9/30/25.

import SwiftUI
import CoreImage.CIFilterBuiltins

struct GlassCardView: View {
    let card: BusinessCard
    var compact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline){
                Text(card.fullName)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                Spacer()
            }
            Text(card.role)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(1)
            Text(card.company)
                .font(.footnote.weight(.medium))
                .foregroundStyle(card.accentColor.gradient)
                .lineLimit(1)
            Divider().opacity(0.25)
            infoRows
            if !compact { socials }
        }
        .padding(18)
        .background(GlassBackground(tint: card.accentColor))
        .overlay(RoundedRectangle(cornerRadius: 24).stroke(card.accentColor.opacity(0.35), lineWidth: 1))
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: card.accentColor.opacity(0.25), radius: 20, y: 8)
        .contentShape(Rectangle())
    }

    private var infoRows: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let phone = card.phone, !phone.isEmpty {
                Label(phone, systemImage: "phone")
                    .labelStyle(.iconOnlyIfCompact(compact))
            }
            if let email = card.email, !email.isEmpty {
                Label(email, systemImage: "envelope")
                    .labelStyle(.iconOnlyIfCompact(compact))
            }
            if let website = card.website?.absoluteString, !website.isEmpty {
                Label(website.replacingOccurrences(of: "https://", with: ""), systemImage: "globe")
                    .labelStyle(.iconOnlyIfCompact(compact))
            }
        }
        .font(.caption)
        .foregroundStyle(.primary)
    }

    private var socials: some View {
        HStack(spacing: 14) {
            if let ig = card.instagram, !ig.isEmpty {
                SocialChip(icon: "camera", text: "@" + ig)
            }
            if let li = card.linkedIn, !li.isEmpty {
                SocialChip(icon: "link", text: li)
            }
        }.padding(.top, 4)
    }
}

private struct SocialChip: View {
    var icon: String
    var text: String
    var body: some View {
        HStack(spacing: 4){
            Image(systemName: icon).font(.caption2)
            Text(text).font(.caption2)
        }
        .padding(.vertical, 4).padding(.horizontal, 8)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(Capsule().strokeBorder(.white.opacity(0.2)))
    }
}

private struct GlassBackground: View {
    var tint: Color
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.linearGradient(colors: [tint.opacity(0.35), tint.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(.ultraThinMaterial)
            Circle().fill(tint.opacity(0.25)).blur(radius: 40).offset(x: -80, y: -70)
            Circle().fill(tint.opacity(0.20)).blur(radius: 50).offset(x: 120, y: 80)
        }
    }
}

private struct IconOnlyIfCompactLabelStyle: LabelStyle { // custom label style
    let compact: Bool
    func makeBody(configuration: Configuration) -> some View {
        if compact { configuration.icon } else { HStack { configuration.icon; configuration.title } }
    }
}

extension LabelStyle where Self == IconOnlyIfCompactLabelStyle {
    static func iconOnlyIfCompact(_ compact: Bool) -> IconOnlyIfCompactLabelStyle { .init(compact: compact) }
}

#Preview {
    GlassCardView(card: BusinessCard(fullName: "Jane Doe", company: "Acme Inc.", role: "iOS Engineer", website: URL(string: "https://acme.com"), instagram: "janedoe", linkedIn: "janedoe", phone: "555-1234", email: "jane@acme.com", accentColor: .purple))
        .padding()
        .background(LinearGradient(colors: [.black,.gray], startPoint: .top, endPoint: .bottom))
}
