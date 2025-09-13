import Foundation
import SwiftData


@Model
final class Movie {
@Attribute(.unique) var id: Int
var title: String
var overview: String?
var releaseDate: Date?
var posterPath: String?
var backdropPath: String?
var genres: [String]
var voteAverage: Double?
var popularity: Double?
var lastRefreshed: Date
var lastAccessedAt: Date


init(id: Int, title: String) {
self.id = id
self.title = title
self.genres = []
self.lastRefreshed = .distantPast
self.lastAccessedAt = Date()
}
}


@Model
final class RankingSystem {
@Attribute(.unique) var slug: String
var name: String
var questions: [Question]


init(slug: String, name: String, questions: [Question]) {
self.slug = slug
self.name = name
self.questions = questions
}
}


@Model
final class Question {
var prompt: String
var weight: Double


init(prompt: String, weight: Double) {
self.prompt = prompt
self.weight = weight
}
}


@Model
final class MovieResponse {
@Relationship var movie: Movie
@Relationship var system: RankingSystem
var answers: [Double]
var computedScore: Double
var createdAt: Date


init(movie: Movie, system: RankingSystem, answers: [Double], computedScore: Double) {
self.movie = movie
self.system = system
self.answers = answers
self.computedScore = computedScore
self.createdAt = Date()
}
}
