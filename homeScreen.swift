
import SwiftUI

struct homeScreen: View {
    @State private var searchText = ""
    let customRed = Color(red: 194 / 255, green: 49 / 255, blue: 44 / 255)

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack{       Spacer()
                        Image("ephslogo") // Ensure this image is in your assets
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75) // Adjust the size as needed
                            .padding(.bottom, -40.0)
                        
                    };           Text("EPHS Media Center")
                                       .font(.largeTitle)
                                       
                               }

                VStack(alignment: .leading, spacing: 20) {
                    SectionView2(
                        title: "Find A Book",
                        description: "See if the media center has a book and the book location.",
                        buttonText: "Find a Book",
                        buttonAction: {
                            // Navigate to book finder
                        },
                        buttonColor: customRed
                    )
                    
                    SectionView1(
                        title: "Media Center Account",
                        description: "Check your rooms reserved, unpaid fees, etc.",
                        buttonText: "Account",
                        buttonAction: {
                            // Navigate to account page
                        },
                        buttonColor: customRed
                    )
                }.padding(.horizontal)
                    .frame(maxWidth: .infinity) // Ensures VStack takes full available width

                
                SectionView3(
                    title: "Printing Instructions",
                    buttonText: "Printer Page",
                    buttonAction: {
                        // Navigate to request book page
                    },
                    buttonColor: customRed
                )
                .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                
                Spacer()
                
                
                VStack{
                    HStack(spacing: 12.5) {
                        Spacer() // pushes the content towards center
                        SectionViewSimple1(
                            title: "Reserve A Room",
                            buttonText: "Reservation Page",
                            buttonAction: {
                                // Navigate to reserve room page
                            },
                            buttonColor: customRed
                        )
                        .frame(width: 165, height: 160) // Adjust size to make square
                        
                        Spacer()
                        
                        SectionViewSimple2(
                            title: "Request A Book",
                            buttonText: "Request Form",
                            buttonAction: {
                                // Navigate to request book page
                            },
                            buttonColor: customRed
                        )
                        .frame(width: 165, height: 160) // Adjust size to make square
                        Spacer() // pushes the content towards center
                        
                    }
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity) // Ensures VStack takes full available width

                Spacer()
                taskBar(selectedTab: 1)
                    .padding()
                    .frame(height: 150.0)
                
                    
                    
            }
            
            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
            
           // .navigationBarTitle("EPHS Media Center", displayMode: .large).position(x: 200, y:350)
            
            
        }.preferredColorScheme(.light)
    }
}
struct SectionView1: View {
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
                .font(.caption)
            Button(action: buttonAction) {
                NavigationLink(destination: accountView().navigationBarBackButtonHidden(true)
                ){
                    Text(buttonText)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct SectionView2: View {
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
                .font(.caption)
            Button(action: buttonAction) {
                NavigationLink(destination: BookFinderView().navigationBarBackButtonHidden(true)
                ){
                    Text(buttonText)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct SectionViewSimple1: View {
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
                NavigationLink(destination: reserveRoom().navigationBarBackButtonHidden(true)
                ){
                    Text(buttonText)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
struct SectionViewSimple2: View {
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
                NavigationLink(destination: RequestFormView().navigationBarBackButtonHidden(true)
            ){
                Text(buttonText)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(buttonColor)
                    .cornerRadius(10)
            }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct SectionView3: View {
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
                NavigationLink(destination: PrinterInstructions().navigationBarBackButtonHidden(true)
                ){
                    Text(buttonText)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(buttonColor)
                        .cornerRadius(10)
                }
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
