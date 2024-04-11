import SwiftUI

struct BookFinderView: View {
    let allBooks = ["The Great Gatsby", "1984", "To Kill a Mockingbird", "Pride and Prejudice", "War and Peace", "The Catcher in the Rye", "Moby Dick"]
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode  // Use the environment to control the presentation mode

    var filteredBooks: [String] {
        if searchText.isEmpty {
            return allBooks
        } else {
            return allBooks.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search for books", text: $searchText)
                    .padding(10)
                    .background(Color(.systemGray5))  // Light grey color for the text field background
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                List(filteredBooks, id: \.self) { book in
                    Text(book)
                        .padding()
                }
                .listStyle(PlainListStyle())
                taskBar()
            }
            .navigationBarTitle(Text("Search Books"), displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        // Clears the search text and dismisses the view
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)) // Custom Red Color for the button
                }
            }
        }
    }
}

struct BookFinderView_Previews: PreviewProvider {
    static var previews: some View {
        BookFinderView()
    }
}
