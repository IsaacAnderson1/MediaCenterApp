import SwiftUI

struct ConfirmReservation: View {
    var roomNumber: Int
    var date: Date
    var period: Int
    var userid: String
    var onConfirm: () -> Void  // Closure to execute on confirmation
    let customRed = Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)

    @Environment(\.presentationMode) var presentationMode

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Confirm Your Reservation")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Room Number: \(roomNumber)")
                    Text("Date: \(dateFormatter.string(from: date))")
                    Text("Period: \(period)")
                }
                .font(.title2)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button("Confirm") {
                        onConfirm()  // Call the closure passed from the parent view
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .background(customRed)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Reservation Details", displayMode: .inline)
        }
    }
}
