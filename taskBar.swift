import SwiftUI

struct taskBar: View {
    var body: some View {
        VStack{
            Divider()
                .background(.black)
            HStack(spacing: 60) { // Adjust the spacing between items
                NavigationLink(destination: accountView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .foregroundColor(.black) // Set foreground color to black
                }
                
                NavigationLink(destination: homeScreen().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .foregroundColor(.black) // Set foreground color to black
                }
                
                NavigationLink(destination: BookFinderView().navigationBarBackButtonHidden(true)) {
                    Image(systemName: "books.vertical.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        .foregroundColor(.black) // Set foreground color to black
                }
            }
            .padding(.bottom, 10)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(Color.white) // Change background color of the task bar to white
            
            .edgesIgnoringSafeArea(.bottom) // Ignore safe area for bottom edge
        }
    }
}

struct TaskBar_Previews: PreviewProvider {
    static var previews: some View {
        taskBar()
    }
}
