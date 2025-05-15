//
//  ContentView.swift
//  Bookworm
//
//  Created by Alexander McGreevy on 4/24/25.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating),
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    @State private var showingAddScreen = false
    


    var body: some View {
        NavigationStack {
           List {
               ForEach(books) { book in
                   NavigationLink(value: book) {
                       HStack {
                           EmojiRatingView(rating: book.rating)
                               .font(.largeTitle)

                           VStack(alignment: .leading) {
                               Text(book.title)
                                   .font(.headline)
                                   .color(book.rating == 1 ? .red : .primary)
                               Text(book.author)
                                   .foregroundStyle(.secondary)
                           }
                       }
                   }
               }.onDelete(perform: deleteBooks)

           }.navigationDestination(for: Book.self) { book in
               DetailView(book: book)
           }
               .navigationTitle("Bookworm")
               .toolbar {
                   ToolbarItem(placement: .topBarTrailing) {
                       Button("Add Book", systemImage: "plus") {
                           showingAddScreen.toggle()
                       }
                   }
                   ToolbarItem(placement: .topBarLeading) {
                       EditButton()
                   }
               }
               .sheet(isPresented: $showingAddScreen) {
                   AddBookView()
               }
       }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let book = books[offset]

            // delete it from the context
            modelContext.delete(book)
        }
    }
}



#Preview {
    ContentView()
}
