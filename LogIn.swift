import SwiftUI

struct Login: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    
    var body: some View {
      
        NavigationView{
        
        
        ZStack {
            Color.gray
                .ignoresSafeArea()
            
            VStack{
                
                //Media Center Logo
                Text("EPHS Media Center")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(width: 400.0, height: 70.0)
                    .background(Rectangle().foregroundColor(Color(red: 0.725, green: 0.0, blue: 0.0))
                    )
                    .foregroundColor(.white)
                    .position(x:200, y:-30).padding(.top, 65.0)
                
                ZStack{
                    Circle()
                        .scale(5)
                        .padding(.bottom, 250.0)
                        .foregroundColor(.white.opacity(0.15))
                    Circle()
                        .scale(4)
                        .padding(.bottom, 250.0)
                        .foregroundColor(.white)
                    VStack{
                        Text("Login")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        TextField("Username", text: $username)
                            .padding()
                            .autocapitalization(.none)
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongUsername))
                       
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .autocapitalization(.none)
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongPassword))
                       
                        
                        Button("Login"){
authenticateUser(username: username, password: password)                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color(red: 0.761, green: 0.0, blue: 0.0))
                        .cornerRadius(10)
                        
                        NavigationLink(destination: homeScreen().navigationBarHidden(true), isActive: $showingLoginScreen){
                            EmptyView()
                               
                        }
                       
                        .padding(.bottom, 2.0)
                        NavigationLink(destination: CreateAccountView().navigationBarHidden(true)){
                            ZStack{
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
    func authenticateUser(username: String, password: String){
        if username.lowercased() == "test"{
            wrongUsername = 0
            if password.lowercased() == "abc123"{
                wrongPassword = 0
                showingLoginScreen = true
            }else{
                wrongPassword = 2
            }
        }else{
            wrongUsername = 2
            }
        }
            
    }
    
    

#Preview {
   Login()
}
