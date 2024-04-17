import SwiftUI

struct RequestFormView: View {
    @State private var bookName: String = ""
    @State private var authorName: String = ""
    @State private var selectedGenre: String = "Sci-Fi"
    let genres = ["Sci-Fi", "Non-Fiction", "Fantasy", "Historical Fiction", "Other"]
    
    // State for handling submission status
    @State private var showingAlert = false
    @State private var alertTitle = "Submission Status"
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Text("Book Request Form")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)
                        
                        fieldCard {
                            VStack(alignment: .center, spacing: 8) {
                                Text("What is the book's title?")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                TextField("Enter Book Name", text: $bookName)
                                    .padding()
                            }
                        }
                        
                        fieldCard {
                            VStack(alignment: .center, spacing: 8) {
                                Text("Author's Name")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                TextField("Enter Name", text: $authorName)
                                    .padding()
                            }
                        }
                        
                        fieldCard {
                            VStack(alignment: .center, spacing: 8) {
                                Text("Select Genre")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Picker("Select Genre", selection: $selectedGenre) {
                                    ForEach(genres, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                        }
                        
                        Button("Submit") {
                            submitForm()
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
                    }
                    .padding()
                }
                Spacer()
                taskBar() // This adds the task bar at the bottom
            }
            .navigationBarTitle("Submit Form", displayMode: .inline)
            .navigationBarItems(leading: backButton)

            .background(Color(.systemGray5)) // Set the background color to light grey
        }
    }
    
    // Helper function to create field cards
    @ViewBuilder
    func fieldCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(radius: 1, x: 0, y: 2)
            
            VStack(alignment: .center) {
                content()
                Divider()
                    .background(Color.gray)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
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
    
    var customRed: Color {
        Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)
    }
    
    
    func submitForm() {
        guard let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLScrshTjSY96YBApfVPJOqR7y5w8hH0ymOOVVvP1p-dF8gr_-A/viewform?usp=sf_link") else {
            alertTitle = "Error"
            alertMessage = "Invalid URL. Please check the form URL."
            showingAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let postData: String = "entry.926706243=\(bookName)&entry.662906640=\(authorName)&entry.1716319514_sentinel=\(selectedGenre)"
        request.httpBody = postData.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.alertTitle = "Network Error"
                    self.alertMessage = "Failed to submit form: \(error.localizedDescription)"
                    self.showingAlert = true
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        self.alertTitle = "Success"
                        self.alertMessage = "Form submitted successfully!"
                    case 400...499:
                        self.alertTitle = "Request Error"
                        self.alertMessage = "Bad request or the request was not accepted by the server."
                    case 500...599:
                        self.alertTitle = "Server Error"
                        self.alertMessage = "Server error. Please try again later."
                    default:
                        self.alertTitle = "Error"
                        self.alertMessage = "An unexpected error occurred."
                    }
                    self.showingAlert = true
                }
            }
        }.resume()
    }
}

struct RequestFormView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFormView()
    }
}
