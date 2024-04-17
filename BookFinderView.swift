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
            .navigationBarItems(leading: backButton)
        }
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")  // System image for back arrow
                Text("Back")
            }
            .foregroundColor(customRed)  // Apply the custom red color here
        }
    }

    var customRed: Color {
        Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)
    }
}

struct BookFinderView_Previews: PreviewProvider {
    static var previews: some View {
        BookFinderView()
    }
}
