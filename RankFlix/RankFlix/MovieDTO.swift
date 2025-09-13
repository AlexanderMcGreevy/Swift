// MovieDTO.swift (subset for demo)
import Foundation


struct MovieDTO: Decodable {
struct Genre: Decodable { let id: Int; let name: String }
let id: Int
let title: String
let overview: String?
let posterPath: String?
let backdropPath: String?
let voteAverage: Double?
let popularity: Double?
let genres: [Genre]


enum CodingKeys: String, CodingKey {
case id, title, overview, genres, popularity
case posterPath = "poster_path"
case backdropPath = "backdrop_path"
case voteAverage = "vote_average"
}
}
