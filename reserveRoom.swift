import SwiftUI

struct reserveRoom: View {
    let periods = 1...4
    let rooms = 1...4
    @State private var roomStatus = Array(repeating: Array(repeating: "Open", count: 4), count: 4)
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false
    let maxReservationDays: Int = 7

    var lastValidDate: Date {
        Calendar.current.date(byAdding: .day, value: maxReservationDays, to: Date()) ?? Date()
    }

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    showingDatePicker.toggle()
                }) {
                    Text("Select Date: \(selectedDate, style: .date)")
                        .foregroundColor(.black)  // Changed text color to black for better contrast on grey
                        .padding()
                        .background(Color(.systemGray5))  // Light grey color
                        .cornerRadius(10)
                }

                if showingDatePicker {
                    DatePicker(
                        "Select Date",
                        selection: $selectedDate,
                        in: Date()...lastValidDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(WheelDatePickerStyle())
                    .padding()
                    .transition(.slide)
                }

                ScrollView {
                    ForEach(periods, id: \.self) { period in
                        periodView(for: period)
                    }
                }
                .padding(.horizontal)
                taskBar()
            }
            .navigationTitle("EPHS Media Center")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))  // General background color for the view
        }
    }

    private func periodView(for period: Int) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Period \(period)")
                .font(.headline)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray5))  // Light grey background for headers
                .cornerRadius(10)

            ForEach(rooms, id: \.self) { room in
                HStack {
                    Text("Room \(room): \(roomStatus[period-1][room-1])")
                    Spacer()
                    Button("Reserve") {
                        reserveRoom(period: period, room: room)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(customRed)  // Using custom red color
                }
                .padding(.vertical, 4)
                .padding(.horizontal)
                .background(Color.white)  // White background for individual room entries
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
        .padding(.vertical, 5)
    }

    private func reserveRoom(period: Int, room: Int) {
        let reservationDate = Calendar.current.startOfDay(for: selectedDate)
        let today = Calendar.current.startOfDay(for: Date())
        let daysAhead = Calendar.current.dateComponents([.day], from: today, to: reservationDate).day!

        if daysAhead <= maxReservationDays {
            roomStatus[period-1][room-1] = (roomStatus[period-1][room-1] == "Open") ? "Reserved" : "Open"
        }
    }

    // Define the custom red color using provided RGB values
    var customRed: Color {
        Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)
    }
}

struct ReserveRoomView_Previews: PreviewProvider {
    static var previews: some View {
        reserveRoom()
    }
}
