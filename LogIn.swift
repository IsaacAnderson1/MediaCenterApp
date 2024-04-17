import SwiftUI
import FirebaseAuth

struct Login: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var authenticationFailed = false
    @State private var showingLoginScreen = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.ignoresSafeArea()
                
                VStack {
                    // Media Center Logo
                    Text("EPHS Media Center")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 400.0, height: 70.0)
                        .background(Rectangle().foregroundColor(Color(red: 0.725, green: 0.0, blue: 0.0)))
                        .foregroundColor(.white)
                        .position(x: 200, y: -30)
                        .padding(.top, 65.0)
                    
                    ZStack {
                        Circle()
                            .scale(5)
                            .padding(.bottom, 250.0)
                            .foregroundColor(.white.opacity(0.15))
                        Circle()
                            .scale(4)
                            .padding(.bottom, 250.0)
                            .foregroundColor(.white)
                        
                        VStack {
                            Text("Login")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            TextField("Username (Email)", text: $username)
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(Color.red, width: CGFloat(authenticationFailed ? 2 : 0))
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(Color.red, width: CGFloat(authenticationFailed ? 2 : 0))
                            
                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            
                            Button("Login") {
                                authenticateUser(username: username, password: password)
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.761, green: 0.0, blue: 0.0))
                            .cornerRadius(10)
                            
                            NavigationLink(destination: homeScreen().navigationBarHidden(true), isActive: $showingLoginScreen) {
                                EmptyView()
                            }
                            .padding(.bottom, 2.0)
                            
                            NavigationLink(destination: CreateAccountView().navigationBarHidden(true)) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 300, height: 50)
                                        .cornerRadius(10)
                                        .foregroundColor(Color(red: 0.761, green: 0.0, blue: 0.0))
                                    Text("Don't have an account?")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .position(CGPoint(x: 200, y: 65))
                    }
                    .position(CGPoint(x: 200, y: 175.0))
                }
            }
        }
    }
    
    func authenticateUser(username: String, password: String) {
        Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.authenticationFailed = true
            } else {
                self.authenticationFailed = false
                self.showingLoginScreen = true  // Proceed to the home screen on successful login
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
