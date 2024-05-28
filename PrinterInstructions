import SwiftUI

struct PrinterInstructions: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    // Define customRed color outside of the body
    var customRed: Color {
        Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Need Help Printing? Read below…")
                        .font(.title)
                        .foregroundColor(customRed)
                    
                    // Instructions Text
                    VStack(alignment: .leading, spacing: 10) {
                        Text("On your laptop:")
                            .fontWeight(.bold)
                        Text("1. Open the document/image/file")
                        Text("2. Click Command+P (⌘ + P)")
                        Text("3. Make sure the printer is:")
                        Text("   Eden Prairie Schools Universal Print")
                        Text("4. Click Print")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("On the printer:")
                            .fontWeight(.bold)
                        Text("1. Touch Pin Code and enter your long student ID number (usually starting in 640…)")
                        Text("2. Touch Login")
                        Text("3. Then touch Secure Print")
                        Text("4. Your document should be listed on the next window.")
                        Text("5. Touch your document to highlight")
                        Text("6. Touch Print + Keep")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("If you do not see your document listed on the printer then you’ll need to:")
                            .fontWeight(.bold)
                        Text("1. Go to Self Service")
                        Text("2. Reinstall or Install Uniflow")
                        Text("3. Return to the printer and try again")
                        Text("4. If this doesn’t work, consult the Lakeside tech support staff.")
                    }
                }
                .padding()
            }
            .navigationBarItems(leading: backButton) // Use backButton here
            .navigationTitle("Printer Instructions")
        }
    }
    
    // Define backButton outside of the body
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
}

struct PrinterInstructions_Previews: PreviewProvider {
    static var previews: some View {
        PrinterInstructions()
    }
}
