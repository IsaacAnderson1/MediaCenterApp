import SwiftUI
import FirebaseFirestore

struct reserveRoom: View {
    private var db = Firestore.firestore()

    let periods = 1...4
    let rooms = 1...4
    @State private var roomStatus = Array(repeating: Array(repeating: "Open", count: 4), count: 4)
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false
    @State private var navigateToConfirm = false
    @State private var selectedRoom: Int = 1
    @State private var selectedPeriod: Int = 1
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let maxReservationDays: Int = 365  // Setting up to a year ahead for reservation

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-d-yyyy"  // Adjusted to match the document ID format
        return formatter
    }

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    self.showingDatePicker.toggle()
                }) {
                    Text("Select Date: \(selectedDate, formatter: dateFormatter)")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(10)
                }

                if showingDatePicker {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        in: Date()...Calendar.current.date(byAdding: .day, value: maxReservationDays, to: Date())!,
                        displayedComponents: .date
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    .transition(.slide)
                    .onChange(of: selectedDate) { newDate in
                        fetchRoomStatuses(date: newDate)
                    }
                }

                ScrollView {
                    ForEach(periods, id: \.self) { period in
                        periodView(for: period)
                    }
                }
                .padding(.horizontal)

                NavigationLink(destination: ConfirmReservationView(roomNumber: selectedRoom, date: selectedDate, period: selectedPeriod, onConfirm: {
                    confirmReservation(room: selectedRoom, date: selectedDate, period: selectedPeriod)
                }), isActive: $navigateToConfirm) {
                    EmptyView()
                }
            }
            .navigationTitle("Reservation System")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: backButton)
            .background(Color(.systemGray6))
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Room Already Reserved"),
                    message: Text("Please choose a different room or period."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onAppear {
//                initializeDateRangeDocuments() //only uncomment when refresh db
            }
        }
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left")
                Text("Back")
            }
            .foregroundColor(.red)
        }
    }

    private func periodView(for period: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Period \(period)")
                .font(.headline)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray5))
                .cornerRadius(10)

            ForEach(rooms, id: \.self) { room in
                HStack {
                    Text("Room \(room): \(roomStatus[period-1][room-1])")
                    Spacer()
                    Button(roomStatus[period-1][room-1] == "Reserved" ? "Reserved" : "Reserve") {
                        selectedRoom = room
                        selectedPeriod = period
                        if roomStatus[period-1][room-1] == "Open" {
                            navigateToConfirm = true
                        } else {
                            showAlert = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(roomStatus[period-1][room-1] == "Reserved" ? Color.gray : Color.red)
                    .disabled(roomStatus[period-1][room-1] == "Reserved")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(roomStatus[period-1][room-1] == "Reserved" ? Color.gray : Color.red, lineWidth: 2)
                )
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
        .padding(.vertical, 5)
    }

    func fetchRoomStatuses(date: Date) {
        let dateString = dateFormatter.string(from: date)
        let docRef = db.collection("reservations").document(dateString)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                for room in 1...4 {
                    if let periodsData = document.data()?["room\(room)"] as? [String: String] {
                        for period in 1...4 {
                            let status = periodsData["period\(period)"] ?? "Open"
                            roomStatus[period-1][room-1] = status
                        }
                    }
                }
            } else {
                print("Document does not exist for date: \(dateString), initializing new document.")
                initializeSingleDocument(date: dateString)
            }
        }
    }

    func confirmReservation(room: Int, date: Date, period: Int) {
        let dateString = dateFormatter.string(from: date)
        let roomField = "room\(room)"
        let periodField = "period\(period)"
        let docRef = db.collection("reservations").document(dateString)

        docRef.setData([roomField: [periodField: "Reserved"]], mergeFields: [roomField + "." + periodField]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                fetchRoomStatuses(date: date)  // Refresh data after update
            }
        }
    }

    func initializeDateRangeDocuments() {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
        var currentDate = startDate
        
        while currentDate <= endDate {
            let dateString = dateFormatter.string(from: currentDate)
            let docRef = db.collection("reservations").document(dateString)
            
            var roomData: [String: Any] = [:]
            for room in 1...4 {
                var periodsData: [String: String] = [:]
                for period in 1...4 {
                    periodsData["period\(period)"] = "Open"
                }
                roomData["room\(room)"] = periodsData
            }
            
            // This sets the rooms map correctly
            docRef.setData(roomData, merge: true) { err in
                if let err = err {
                    print("Error initializing document for date \(dateString): \(err)")
                } else {
                    print("Document initialized for date: \(dateString)")
                }
            }
            
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
    }

    func initializeSingleDocument(date: String) {
        let docRef = db.collection("reservations").document(date)
        var initialData = [String: Any]()

        for room in 1...4 {
            var periodsData = [String: String]()
            for period in 1...4 {
                periodsData["period\(period)"] = "Open"
            }
            initialData["room\(room)"] = periodsData
        }

        docRef.setData(["rooms": initialData], merge: true) { err in
            if let err = err {
                print("Error initializing document for date \(date): \(err)")
            } else {
                print("Document initialized for date: \(date)")
            }
        }
    }
}

struct ConfirmReservationView: View {
    var roomNumber: Int
    var date: Date
    var period: Int
    var onConfirm: () -> Void

    var body: some View {
        VStack {
            Text("Confirm Reservation")
            Text("Room \(roomNumber), Period \(period) on \(date, formatter: DateFormatter())")
            Button("Confirm") {
                onConfirm()
            }
        }
    }
}

struct ReserveRoomView_Previews: PreviewProvider {
    static var previews: some View {
        reserveRoom()
    }
}
