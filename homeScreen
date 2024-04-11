import SwiftUI

struct homeScreen: View {
    @State private var searchText = ""
    let customRed = Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 20) {
                    SectionView(
                        title: "Find A Book",
                        description: "See if the media center has a book and where it might be.",
                        buttonText: "Find a Book",
                        buttonAction: { /* Navigate to book finder */ },
                        buttonColor: customRed
                    )
                    
                    SectionView(
                        title: "Media Center Account",
                        description: "See what books you have checked out, what fees you have to pay, etc.",
                        buttonText: "Account",
                        buttonAction: { /* Navigate to account page */ },
                        buttonColor: customRed
                    )
                }.padding(.horizontal)
                    .frame(maxWidth: .infinity) // Ensures VStack takes full available width

                VStack{
                    HStack(spacing: 12.5) {
                        Spacer() // pushes the content towards center
                        SectionViewSimple(
                            title: "Reserve A Room",
                            buttonText: "Reservation Page",
                            buttonAction: { /* Navigate to reserve room page */ },
                            buttonColor: customRed
                        )
                        .frame(width: 165, height: 160) // Adjust size to make square
                        
                        Spacer()
                        
                        SectionViewSimple(
                            title: "Request A Book",
                            buttonText: "Request Form",
                            buttonAction: { /* Navigate to request book page */ },
                            buttonColor: customRed
                        )
                        .frame(width: 165, height: 160) // Adjust size to make square
                        Spacer() // pushes the content towards center
                    }
                
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity) // Ensures VStack takes full available width

                Spacer()
                taskBar()
            }
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            .navigationBarTitle("EPHS Media Center", displayMode: .large)
            .navigationBarItems(trailing: menuButton)
        }
    }

    var menuButton: some View {
        Menu {
            Button("Account", action: { /* Navigate to account page */ })
            Button("Request Book", action: { /* Navigate to request book page */ })
            Button("Help Center", action: { /* Navigate to help center */ })
        } label: {
            HStack {
                Text("Menu")
                Image(systemName: "chevron.down")
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .foregroundColor(.white)
            .background(customRed)
            .cornerRadius(10)
        }
        .frame(width: UIScreen.main.bounds.width / 2, alignment: .trailing)
    }
}

struct SectionView: View {
    let title: String
    let description: String
    let buttonText: String
    let buttonAction: () -> Void
    let buttonColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .underline()
            Text(description)
                .font(.subheadline)
            Button(action: buttonAction) {
                Text(buttonText)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct SectionViewSimple: View {
    let title: String
    let buttonText: String
    let buttonAction: () -> Void
    let buttonColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .underline()
            Button(action: buttonAction) {
                Text(buttonText)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
    }
}
