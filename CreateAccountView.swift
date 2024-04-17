import SwiftUI
import FirebaseAuth

struct CreateAccountView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var usernameTaken = 0
    @State private var passwordMatch = 0
    @State private var passwordDoNotMatch = 0
    @State private var showingLoginScreen = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.ignoresSafeArea()
                VStack {
                    Spacer()
                    //Media Center Logo
                    Text("EPHS Media Center")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 400.0, height: 70.0)
                        .background(Rectangle().foregroundColor(Color(red: 0.761, green: 0.173, blue: 0.192)))
                        .foregroundColor(.white)
                        .position(x: 200, y: 25)

                    ZStack {
                        Circle()
                            .scale(5.5)
                            .padding(.bottom, 250.0)
                            .foregroundColor(.white.opacity(0.15))
                        Circle()
                            .scale(4.5)
                            .padding(.bottom, 250.0)
                            .foregroundColor(.white)

                        VStack {
                            Text("Sign Up")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            TextField("Username (Email)", text: $username)
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(Color.red, width: CGFloat(usernameTaken))
                            if usernameTaken == 1 {
                                Text("Username Taken")
                                    .foregroundColor(.red)
                            }
                            SecureField("Password", text: $password)
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                            SecureField("Confirm Password", text: $confirmPassword)
                                .padding()
                                .autocapitalization(.none)
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(Color.red, width: CGFloat(passwordMatch))
                            if passwordDoNotMatch == 0 {

                            } else {
                                Text("Passwords do not match")
                                    .foregroundColor(.red)
                            }
                            Button("Create Account") {
                                checkSignUp(username: username, password: password, confirmPassword: confirmPassword)
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color(red: 0.761, green: 0.173, blue: 0.192))
                            .cornerRadius(10)

                            if !errorMessage.isEmpty {
                                Text(errorMessage)
                                    .foregroundColor(.red)
                                    .padding()
                            }

                            NavigationLink(destination: homeScreen().navigationBarHidden(true), isActive: $showingLoginScreen) {
                                EmptyView()
                            }
                        }
                        .position(CGPoint(x: 200, y: 50))
                    }
                    .position(CGPoint(x: 200, y: 175))
                }
            }
        }
    }

    func checkSignUp(username: String, password: String, confirmPassword: String) {
        if username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill in all fields"
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }

        Auth.auth().createUser(withEmail: username, password: password) { authResult, error in
            if let error = error {
                errorMessage = "Firebase error: \(error.localizedDescription)"
            } else {
                showingLoginScreen = true  // Navigate to home screen on success
            }
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
