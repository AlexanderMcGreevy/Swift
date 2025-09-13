// ScoreBadge.swift
import SwiftUI


struct ScoreBadge: View {
let score: Double
var body: some View {
Text(String(format: "%.1f", score))
.font(.caption).bold()
.padding(.horizontal, 8).padding(.vertical, 4)
.background(
Capsule().fill(Color(.systemGray6))
)
}
}
