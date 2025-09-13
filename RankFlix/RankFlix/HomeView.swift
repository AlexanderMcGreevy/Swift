// HomeView.swift
import SwiftUI
import SwiftData


struct HomeView: View {
@Environment(\.modelContext) private var context
@StateObject private var vm: HomeViewModel


init(repo: MovieRepository, context: ModelContext) {
_vm = StateObject(wrappedValue: HomeViewModel(repo: repo, context: context))
}


var body: some View {
NavigationStack {
ScrollView {
VStack(alignment: .leading, spacing: 16) {
SearchBar(placeholder: "Search movies...") { query in
// navigate to SearchView
}


if !vm.continueRanking.isEmpty {
SectionHeader("Continue Ranking")
ScrollView(.horizontal, showsIndicators: false) {
HStack(spacing: 12) {
ForEach(vm.continueRanking, id: \.createdAt) { resp in
NavigationLink(value: resp.movie.id) {
PosterView(path: resp.movie.posterPath, width: 110, height: 165)
.overlay(alignment: .bottomLeading) {
ScoreBadge(score: resp.computedScore)
.padding(6)
}
}
}
}.padding(.horizontal)
}
}


SectionHeader("Trending")
LazyVStack(spacing: 12) {
ForEach(vm.trending, id: \.id) { movie in
NavigationLink(value: movie.id) {
MovieRow(movie: movie)
}
}
}.padding(.horizontal)


SectionHeader("My Top Rated")
LazyVGrid(columns: [GridItem(.adaptive(minimum: 110), spacing: 12)], spacing: 12) {
ForEach(vm.myTopRated, id: \.id) { movie in
NavigationLink(value: movie.id) {
PosterView(path: movie.posterPath, width: 110, height: 165)
.accessibilityLabel(Text(movie.title))
}
}
}.padding(.horizontal)
}
}
.navigationTitle("RankFlix")
.task { await vm.load() }
}
}
}


private struct SectionHeader: View {
let title: String
init(_ t: String) { self.title = t }
var body: some View {
Text(title)
.font(.title2).bold()
.padding(.horizontal)
.padding(.top, 8)
}
}
