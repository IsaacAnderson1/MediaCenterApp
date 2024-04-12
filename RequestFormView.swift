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
            .navigationBarHidden(true)
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
    
    func submitForm() {
        guard let url = URL(string: "https://forms.gle/wN8Vyqe9VfSJ8WPv5") else {
            alertTitle = "Error"
            alertMessage = "Invalid URL. Please check the form URL."
            showingAlert = true
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    self.alertTitle = "Error"
                    self.alertMessage = "Server error. Please try again later."
                    self.showingAlert = true
                    return
                }
                self.alertTitle = "Success"
                self.alertMessage = "Form submitted successfully!"
                self.showingAlert = true
            }
        }.resume()
    }
}


struct RequestFormView_Previews: PreviewProvider {
    static var previews: some View {
        RequestFormView()
    }
}
