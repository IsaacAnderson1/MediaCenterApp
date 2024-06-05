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
                VStack{
                    Text("Confirm Your Reservation")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Room Number: \(roomNumber)")
                        Text("Date: \(dateFormatter.string(from: date))")
                        Text("Period: \(period)")
                    }
                    .font(.title2)
                }.background(Rectangle().frame(width: 370.0, height: 180.0).cornerRadius(20).foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.741)/*@END_MENU_TOKEN@*/).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).position(x:165, y:80))
                    
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button("Confirm") {
                        onConfirm()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .frame(height: 100.0)
                    .background(customRed)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .frame(height: 100.0)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                }
                .position(x:180, y:50)
                
                Spacer()
            }
            .padding()
            .navigationBarTitle("Reservation Details", displayMode: .inline)
        }
    }
}

struct ConfirmReservation_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmReservation(roomNumber: 101, date: Date(), period: 3, userid: "user123", onConfirm: {})
    }
}
