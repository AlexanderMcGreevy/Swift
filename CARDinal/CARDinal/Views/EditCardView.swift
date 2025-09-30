//  EditCardView.swift
//  CARDinal
//
//  Form to edit the user's business card details.
//
//  Created by AI Assistant on 9/30/25.

import SwiftUI

struct EditCardView: View {
    @EnvironmentObject var store: CardStore
    @Environment(\.dismiss) private var dismiss

    @State private var draft: BusinessCard = BusinessCard()
    @State private var color: Color = .cyan

    var body: some View {
        NavigationStack {
            Form {
                Section("Identity") {
                    TextField("Full Name", text: binding(\.fullName))
                    TextField("Company", text: binding(\.company))
                    TextField("Role / Title", text: binding(\.role))
                }
                Section("Contact") {
                    TextField("Phone", text: binding(\.phone, default: ""))
                        .keyboardType(.phonePad)
                    TextField("Email", text: binding(\.email, default: ""))
                        .keyboardType(.emailAddress)
                    TextField("Website (https://...)", text: websiteBinding())
                        .keyboardType(.URL)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section("Social") {
                    TextField("Instagram (handle only)", text: binding(\.instagram, default: ""))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("LinkedIn (profile slug)", text: binding(\.linkedIn, default: ""))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                Section("Accent Color") {
                    ColorPicker("Accent", selection: $color, supportsOpacity: false)
                    Rectangle().fill(color.gradient).frame(height: 44).clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(Text("Preview").font(.caption).foregroundStyle(.white.opacity(0.7)))
                }
                Section("Preview") {
                    GlassCardView(card: previewCard, compact: true)
                        .listRowInsets(EdgeInsets())
                        .frame(maxWidth: .infinity, minHeight: 160)
                        .background(Color.clear)
                }
            }
            .navigationTitle("Edit Card")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel", action: { dismiss() }) }
                ToolbarItem(placement: .confirmationAction) { Button("Save", action: save).bold() }
            }
            .onAppear { load() }
        }
    }

    private var previewCard: BusinessCard {
        var c = draft
        c.accentColorHex = color.toHex()
        return c
    }

    private func load() {
        draft = store.myCard
        color = store.myCard.accentColor
    }

    private func save() {
        store.updateMyCard { current in
            current.fullName = draft.fullName
            current.company = draft.company
            current.role = draft.role
            current.phone = draft.phone
            current.email = draft.email
            current.instagram = draft.instagram
            current.linkedIn = draft.linkedIn
            current.website = draft.website
            current.accentColorHex = color.toHex()
        }
        dismiss()
    }

    // MARK: - Bindings helpers
    private func binding<T>(_ keyPath: WritableKeyPath<BusinessCard, T>) -> Binding<T> {
        Binding(get: { draft[keyPath: keyPath] }, set: { draft[keyPath: keyPath] = $0 })
    }

    private func binding(_ keyPath: WritableKeyPath<BusinessCard, String?>, default def: String) -> Binding<String> {
        Binding<String>(get: { draft[keyPath: keyPath] ?? def }, set: { draft[keyPath: keyPath] = $0.isEmpty ? nil : $0 })
    }

    private func websiteBinding() -> Binding<String> {
        Binding<String>(get: { draft.website?.absoluteString ?? "" }, set: { newVal in
            draft.website = URL(string: newVal.trimmingCharacters(in: .whitespacesAndNewlines))
        })
    }
}

#Preview {
    EditCardView().environmentObject(CardStore())
}
