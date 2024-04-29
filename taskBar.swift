import SwiftUI

struct taskBar: View {
    @State var selectedTab: Int
    
    var body: some View {
        HStack() {
            Spacer()
  
            NavigationLink(destination: accountView().navigationBarBackButtonHidden(true)) {
                Image(systemName: selectedTab == 0 ? "person.crop.circle.fill" : "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedTab == 0 ? .red : .black)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .frame(width: 70.0, height: 50.0)
                        .foregroundColor(.gray)
                        .opacity(selectedTab == 0 ? 0.2 : 0) // Only show background when selectedTab is 0
                        )
            }
            Spacer()
            

            NavigationLink(destination: homeScreen().navigationBarBackButtonHidden(true)) {
                Image(systemName: selectedTab == 1 ? "house.fill" : "house")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedTab == 1 ? .red : .black)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .frame(width: 70.0, height: 50.0)
                        .foregroundColor(.gray)
                        .opacity(selectedTab == 1 ? 0.2 : 0) // Only show background when selectedTab is 1
                        )
            }
            Spacer()
            

            NavigationLink(destination: BookFinderView().navigationBarBackButtonHidden(true)) {
                Image(systemName: selectedTab == 2 ? "books.vertical.fill" : "books.vertical")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedTab == 2 ? .red : .black)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .frame(width: 70.0, height: 50.0)
                        .foregroundColor(.gray)
                        .opacity(selectedTab == 2 ? 0.2 : 0) // Only show background when selectedTab is 2
                        )
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 60)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 5)
        .padding(.horizontal, 10)
        .padding(.bottom, 5)
    }
}

struct TaskBar_Previews: PreviewProvider {
    static var previews: some View {
        homeScreen()
    }
}
