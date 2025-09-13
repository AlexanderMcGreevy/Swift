// MovieRepository.swift
import Foundation
import SwiftData


@MainActor
final class MovieRepository {
let context: ModelContext
let tmdb: TMDBService


init(context: ModelContext, tmdb: TMDBService) {
self.context = context
self.tmdb = tmdb
}


func movie(id: Int, ttl: TimeInterval = 60*60*24) async throws -> Movie {
if let cached = try? context.fetch(FetchDescriptor<Movie>(predicate: #Predicate { $0.id == id })).first {
cached.lastAccessedAt = Date()
if Date().timeIntervalSince(cached.lastRefreshed) < ttl { return cached }
}
let dto = try await tmdb.details(for: id)
let m = upsert(dto)
m.lastRefreshed = Date()
try context.save()
return m
}


private func upsert(_ dto: MovieDTO) -> Movie {
if let existing = try? context.fetch(FetchDescriptor<Movie>(predicate: #Predicate { $0.id == dto.id })).first {
existing.title = dto.title
existing.overview = dto.overview
existing.posterPath = dto.posterPath
existing.backdropPath = dto.backdropPath
existing.genres = dto.genres.map { $0.name }
existing.voteAverage = dto.voteAverage
existing.popularity = dto.popularity
return existing
} else {
let m = Movie(id: dto.id, title: dto.title)
m.overview = dto.overview
m.posterPath = dto.posterPath
m.backdropPath = dto.backdropPath
m.genres = dto.genres.map { $0.name }
m.voteAverage = dto.voteAverage
m.popularity = dto.popularity
context.insert(m)
return m
}
}
}
