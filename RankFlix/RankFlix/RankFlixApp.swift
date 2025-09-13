// RankFlixApp.swift
import SwiftUI
import SwiftData


@main
struct RankFlixApp: App {
var body: some Scene {
WindowGroup {
Root()
}
.modelContainer(for: [Movie.self, RankingSystem.self, Question.self, MovieResponse.self])
}
}


struct Root: View {
@Environment(\.modelContext) private var context
var body: some View {
let service = TMDBService(apiKeyProvider: { Secrets.tmdbBearer })
let repo = MovieRepository(context: context, tmdb: service)
HomeView(repo: repo, context: context)
}
}


enum Secrets { // load from plist/Keychain in real app
static let tmdbBearer = "<YOUR_TMDB_BEARER_TOKEN>"
}
