import SwiftUI

struct accountView: View {
    // Example data - this would typically be fetched from a database or API
    let reservedBooks = [
        ("Book One", "May 1", "book_one_cover"),
        ("Book Two", "May 5", "book_two_cover"),
        ("Book Three", "May 10", "book_three_cover")
    ]
    let reservedRooms: [String] = [] // No rooms reserved

    var body: some View {
        NavigationView {
            ZStack {
                Color(.sRGB, red: 245/255, green: 245/255, blue: 245/255, opacity: 1.0) // Light gray background
                    .ignoresSafeArea()
                
                VStack(alignment: .center, spacing: 10) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 15) {
                            bookSection
                            roomSection
                        }
                        .padding(.horizontal)
                    }
                    Spacer()
                    taskBar()
                }
            }
            .navigationBarTitle("EPHS Media Center", displayMode: .large)
            .navigationBarItems(trailing: menuButton)
        }
    }
    
    var bookSection: some View {
        VStack {
            Text("Your Books:")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(customRed) // Using custom red color
                .cornerRadius(10)
            
            VStack(spacing: 10) { // Space between books
                ForEach(reservedBooks, id: \.0) { book in
                    bookEntry(book)
                }
            }
            .background(Color.white) // White background for the book list
            .cornerRadius(10)
        }
        .background(Color.white) // Consistent section background
        .cornerRadius(12)
        .shadow(radius: 5)
    }
    
    func bookEntry(_ book: (String, String, String)) -> some View {
        HStack {
            Image(book.2)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 70)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(book.0)
                    .fontWeight(.medium)
                Text("Due: \(book.1)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Spacer()
        }
        .padding()
        .background(Color.white) // White card background
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    var roomSection: some View {
        Section(header: Text("Rooms Reserved:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(customRed) // Using custom red color
                    .cornerRadius(12)) {
            if reservedRooms.isEmpty {
                Text("You have no rooms currently reserved.")
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(12)
            } else {
                ForEach(reservedRooms, id: \.self) { room in
                    Text(room)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(12)
                }
            }
        }
        .background(customRed) // Matching background for consistency
        .cornerRadius(12)
    }
    
    var menuButton: some View {
        Menu(content: {
            Button("Profile", action: {})
            Button("Logout", action: {})
        }, label: {
            HStack {
                Text("Menu")
                Image(systemName: "chevron.down")
            }
            .padding(8)
            .background(customRed) // Using custom red color
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
    
    // Define the custom red color
    var customRed: Color {
        Color(.sRGB, red: 194/255, green: 49/255, blue: 44/255, opacity: 1)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        accountView()
    }
}
