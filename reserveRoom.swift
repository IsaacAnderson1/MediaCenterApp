import SwiftUI

struct reserveRoom: View {
    let periods = 1...4
    let rooms = 1...4
    @State private var roomStatus = Array(repeating: Array(repeating: "Open", count: 4), count: 4)
    @State private var selectedDate = Date()
    @State private var showingDatePicker = false
    @State private var navigateToConfirm = false
    @State private var selectedRoom: Int = 1
    @State private var selectedPeriod: Int = 1
    @State private var showAlert = false  // State to control alert visibility
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
                        .foregroundColor(.black)
                        .padding()
                        .background(Color(.systemGray5))
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

                NavigationLink(destination: ConfirmReservation(roomNumber: selectedRoom, date: selectedDate, period: selectedPeriod, onConfirm: {
                    roomStatus[selectedPeriod-1][selectedRoom-1] = "Reserved"
                }), isActive: $navigateToConfirm) {
                    EmptyView()
                }
            }
            .navigationTitle("EPHS Media Center")
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
        }
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "arrow.left") // System name for back arrow
                Text("Back")
            }
            .foregroundColor(customRed)
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
                    Button("Reserve") {
                        selectedRoom = room
                        selectedPeriod = period
                        if roomStatus[period-1][room-1] == "Open" {
                            navigateToConfirm = true
                        } else {
                            showAlert = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(roomStatus[period-1][room-1] == "Reserved" ? Color.gray : customRed)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(roomStatus[period-1][room-1] == "Reserved" ? Color.gray : customRed, lineWidth: 2)
                )
                .cornerRadius(10)
                .shadow(radius: 2)
            }
        }
        .padding(.vertical, 5)
    }

    var customRed: Color {
        Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)
    }
}

struct ReserveRoomView_Previews: PreviewProvider {
    static var previews: some View {
        reserveRoom()
    }
}
