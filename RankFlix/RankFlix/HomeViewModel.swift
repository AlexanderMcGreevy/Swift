// HomeViewModel.swift
import Foundation
import SwiftData


@MainActor
final class HomeViewModel: ObservableObject {
@Published var trending: [Movie] = []
@Published var continueRanking: [MovieResponse] = []
@Published var myTopRated: [Movie] = []


private let repo: MovieRepository
private let context: ModelContext


init(repo: MovieRepository, context: ModelContext) {
self.repo = repo
self.context = context
}


func load() async {
// NOTE: Replace with your real endpoints / cached queries
// For now, just pull a few hard-coded IDs to demonstrate
let demoIDs = [550, 603, 155] // Fight Club, The Matrix, The Dark Knight
var movies: [Movie] = []
for id in demoIDs {
if let m = try? await repo.movie(id: id) { movies.append(m) }
}
trending = movies
myTopRated = movies.sorted { ($0.voteAverage ?? 0) > ($1.voteAverage ?? 0) }
// ContinueRanking would come from SwiftData query on MovieResponse
continueRanking = (try? context.fetch(FetchDescriptor<MovieResponse>())) ?? []
}
}
