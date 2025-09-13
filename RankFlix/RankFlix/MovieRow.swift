// MovieRow.swift
import SwiftUI


struct MovieRow: View {
let movie: Movie


var body: some View {
HStack(spacing: 12) {
PosterView(path: movie.posterPath, width: 70, height: 105)
.cornerRadius(8)
VStack(alignment: .leading, spacing: 6) {
Text(movie.title)
.font(.headline)
.lineLimit(2)
if let genres = movie.genres.first {
Text(genres)
.font(.subheadline)
.foregroundColor(.secondary)
}
HStack(spacing: 8) {
if let vote = movie.voteAverage {
ScoreBadge(score: vote)
}
Text("Seen · Rank now")
.font(.caption)
.foregroundColor(.blue)
}
}
Spacer()
}
.contentShape(Rectangle())
}
}
