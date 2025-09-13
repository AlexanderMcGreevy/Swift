// TMDBService.swift
import Foundation


struct TMDBService {
let apiKeyProvider: () -> String
let baseURL = URL(string: "https://api.themoviedb.org/3")!


func details(for id: Int, append: [String] = ["credits","images"]) async throws -> MovieDTO {
var comps = URLComponents(url: baseURL.appendingPathComponent("movie/\(id)"), resolvingAgainstBaseURL: false)!
comps.queryItems = [
URLQueryItem(name: "append_to_response", value: append.joined(separator: ","))
]
var req = URLRequest(url: comps.url!)
req.addValue("Bearer \(apiKeyProvider())", forHTTPHeaderField: "Authorization")
let (data, resp) = try await URLSession.shared.data(for: req)
guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
return try JSONDecoder().decode(MovieDTO.self, from: data)
}
}
