// PosterView.swift (basic AsyncImage wrapper)
import SwiftUI


struct PosterView: View {
let path: String?
var width: CGFloat = 120
var height: CGFloat = 180


var body: some View {
ZStack {
if let path = path, let url = URL(string: "https://image.tmdb.org/t/p/w342\(path)") {
AsyncImage(url: url) { phase in
switch phase {
case .success(let img):
img.resizable().scaledToFill()
case .failure(_):
Color.gray.opacity(0.2)
case .empty:
Color.gray.opacity(0.1)
@unknown default:
Color.gray
}
}
} else {
Color.gray.opacity(0.1)
}
}
.frame(width: width, height: height)
.clipShape(RoundedRectangle(cornerRadius: 10))
.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.05)))
}
}
