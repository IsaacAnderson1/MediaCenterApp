import SwiftUI
import Firebase

struct accountView: View {
    // Example data for books - this would typically be fetched from a database or API
    let reservedBooks = [
        ("Book One", "May 1", "book_one_cover"),
        ("Book Two", "May 5", "book_two_cover"),
        ("Book Three", "May 10", "book_three_cover")
    ]
    @State private var reservedRooms: [String] = [] // State to hold room data
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.sRGB, red: 245/255, green: 245/255, blue: 245/255, opacity: 1.0)
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
            .navigationBarItems(leading: menuButton)
            .navigationBarItems(trailing:  Image("ephslogo")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125))
            .onAppear(perform: loadReservedRooms)
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
            Image(book.2)  // Assume book.2 is the image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 70)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 2)  // Black border for contrast
                )
            
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
            .background(customRed)
            .cornerRadius(12)) {
                if reservedRooms.isEmpty {
                    Text("You have no rooms currently reserved.")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(12)
                } else {
                    ForEach(reservedRooms, id: \.self) { reservation in
                        HStack {
                            Text(reservation)
                                .padding()
                            Spacer()
                            Button(action: {
                                cancelReservation(reservation: reservation)
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(customRed)
                                    .cornerRadius(8)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                    }
                }
            }
            .background(customRed)
            .cornerRadius(12)
    }
    
    
    var menuButton: some View {
        Menu(content: {
            Button("Profile", action: {})
            Button("Contact", action: {})  // Added contact option
            Button("Logout", action: {})   // Added logout option
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
    
    var customRed: Color {
        Color(.sRGB, red: 194/255, green: 49/255, blue: 44/255, opacity: 1)
    }
    
    // Function to fetch reserved rooms from Firebase
    // Function to fetch reserved rooms from Firebase
    func loadReservedRooms() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Debug: No user is currently logged in.")
            return
        }
        
        let db = Firestore.firestore()
        
        // Calculate the date range
        let today = Date()
        let sevenDaysLater = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        
        // Format dates to match the Firestore document IDs
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let todayStr = dateFormatter.string(from: today)
        let sevenDaysLaterStr = dateFormatter.string(from: sevenDaysLater)
        
        db.collection("reservations")
            .whereField(FieldPath.documentID(), isGreaterThanOrEqualTo: todayStr)
            .whereField(FieldPath.documentID(), isLessThanOrEqualTo: sevenDaysLaterStr)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                    return
                }
                
                var userReservations: [String] = []
                snapshot?.documents.forEach { document in
                    let date = document.documentID
                    let data = document.data()
                    
                    // Iterate through each room in the document
                    for (roomKey, roomValue) in data {
                        guard let roomDetails = roomValue as? [String: Any] else { continue }
                        
                        // Iterate through each period in the room
                        for (periodKey, periodValue) in roomDetails {
                            guard let periodDetails = periodValue as? [String: Any],
                                  let status = periodDetails["status"] as? String,
                                  let reservedUserID = periodDetails["userID"] as? String,
                                  status == "Reserved" && reservedUserID == userId else {
                                    continue
                                }
                            userReservations.append("\(date) - \(roomKey), \(periodKey)")
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.reservedRooms = userReservations
                    if userReservations.isEmpty {
                        print("Debug: No reserved rooms found within 7 days.")
                    }
                }
            }
    }

    
    func cancelReservation(reservation: String) {
       // print("Attempting to cancel reservation with string: \(reservation)")
        // Split the reservation string to extract the date, room, and period
        let reservationComponents = reservation.components(separatedBy: " - ")
        guard reservationComponents.count == 2,
              let dateComponent = reservationComponents.first,
              let roomPeriodComponent = reservationComponents.last?.components(separatedBy: ", "),
              roomPeriodComponent.count == 2 else {
            print("Error: Reservation string format is incorrect.")
            return
        }
        
        let date = dateComponent.trimmingCharacters(in: .whitespacesAndNewlines)
        let roomWithPrefix = roomPeriodComponent[0]
        let periodWithPrefix = roomPeriodComponent[1]
        
        guard let room = roomWithPrefix.split(separator: ":").map(String.init).last?.trimmingCharacters(in: .whitespacesAndNewlines),
              let period = periodWithPrefix.split(separator: ":").map(String.init).last?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            print("Error: Could not extract room or period from reservation string.")
            return
        }
        
        // Construct the path to the specific period's status and userID
        let statusPath = "\(room).\(period).status"
        let userIDPath = "\(room).\(period).userID"
        
        // Get a reference to the Firestore database
        let db = Firestore.firestore()
        
        // Create a reference to the specific document using the extracted date
        let documentReference = db.collection("reservations").document(date)
        
        // Update the status and userID to "Open" and an empty string, respectively
        documentReference.updateData([
            statusPath: "Open",
            userIDPath: ""
        ]) { error in
            if let error = error {
                print("Error updating document: \(error.localizedDescription)")
            } else {
                print("Reservation cancelled successfully.")
                // Optionally, refresh the reservation list if needed
                 self.loadReservedRooms()
            }
        }
    }
}
struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        accountView()
    }
}
