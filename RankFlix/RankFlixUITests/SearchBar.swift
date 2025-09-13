// SearchBar.swift
import SwiftUI


struct SearchBar: View {
var placeholder: String = "Search"
var onSubmit: (String) -> Void
@State private var text = ""


var body: some View {
HStack {
Image(systemName: "magnifyingglass")
TextField(placeholder, text: $text, onCommit: { onSubmit(text) })
.textInputAutocapitalization(.never)
.disableAutocorrection(true)
if !text.isEmpty {
Button { text = "" } label: { Image(systemName: "xmark.circle.fill") }
}
}
.padding(10)
.background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
.padding(.horizontal)
}
}
