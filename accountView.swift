//
//  accountView.swift
//  LibraryApp
//
//  Created by 90308214 on 4/2/24.
//

import SwiftUI


struct accountView: View {
    
    var body: some View {
        NavigationView{
            
            
            
            ZStack {
                Color.gray
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        
                        
                  
                        
                        Text("Signed In As: " ).foregroundColor(.white)
                        
                        Spacer()
                        
                    }.padding(.top, 50.0).ignoresSafeArea()
                    //Media Center Logo
                    Text("EPHS Media Center")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(width: 400.0, height: 70.0)
                        .background(Rectangle().foregroundColor(Color(red: 0.525, green: 0.0, blue: 0.0))
                        )
                        .foregroundColor(.white)
                        .position(x:200, y:-30)
                    
                    
                    //             INSERT CODE HERE!!!!!!!!!
                    //             INSERT CODE HERE!!!!!!!!!
                    //             INSERT CODE HERE!!!!!!!!!
                    //             INSERT CODE HERE!!!!!!!!!
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/).frame(width: 390, height: 280).foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851)).position(x: 195, y: -80)
                        
                        Text("Your Books:").position(x: 65,y: -190)
                        Text("Title").position(x: 65,y: -160)
                        Text("Title").position(x: 190,y: -160)
                        Text("Title").position(x: 315,y: -160)
                        RoundedRectangle(cornerRadius: 15).frame(width: 100,height: 100).foregroundColor(Color(red: 100, green: 0, blue: 0)).position(x: 70,y: -80)
                        RoundedRectangle(cornerRadius: 15).frame(width: 100,height: 100).foregroundColor(Color(red: 100, green: 0, blue: 0)).position(x: 195,y: -80)
                        RoundedRectangle(cornerRadius: 15).frame(width: 100,height: 100).foregroundColor(Color(red: 100, green: 0, blue: 0)).position(x: 320,y: -80)
                        Text("Due:").position(x: 40,y: -10)
                        Text("Due:").position(x: 165,y: -10)
                        Text("Due:").position(x: 290,y: -10)
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/10.0/*@END_MENU_TOKEN@*/).frame(width: 390, height: 150).foregroundColor(Color(red: 0.851, green: 0.851, blue: 0.851)).position(x: 195, y: 190)
                        Text("Rooms Reserved:").position(x: 80,y: 140)
                        Text("You have no rooms currently reserved.").position(x: 190,y: 190)
                    }
                    
              
                    taskBar().padding(-30)
                }
               
                    
            }
        }
    }
}
#Preview {
    accountView()
}
