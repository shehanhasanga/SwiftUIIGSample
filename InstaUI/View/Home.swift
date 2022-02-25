//
//  Home.swift
//  InstaUI
//
//  Created by shehan karunarathna on 2022-02-25.
//

import SwiftUI

struct Home: View {
    init(){
        UITabBar.appearance().isHidden = true
    }
    @State var currentTab : String = "circle.fill"
    var body: some View {
        VStack(spacing:0){
            TabView(selection:$currentTab){
                Text("Home")
                    .tag("house.fill")
                Text("Search")
                    .tag("magnifyingglass")
                ReelsView()
                    .tag("circle.fill")
                Text("Liked")
                    .tag("heart.fill")
                Text("Profile")
                    .tag("person.circle")
            }
            HStack{
                ForEach(["house.fill","magnifyingglass","circle.fill","heart.fill","person.circle"],id:\.self){
                    image in
                    
                    TabBarButton(image: image, issystemImage: true, cuurentTab: $currentTab)
                }
            }
            .padding()
            .overlay(Divider(), alignment: .top)
            .background(currentTab == "circle.fill" ?  Color.black : .white)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabBarButton: View {
    var image:String
    var issystemImage:Bool
    @Binding var cuurentTab:String
    var body: some View {
        Button{
            withAnimation {
                cuurentTab = image
            }
        }label: {
            ZStack{
                if issystemImage{
                    Image(systemName: image)
                        .font(.title2)
                } else {
                    Image(image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 25, height: 25)
                    
                }
            }
            .foregroundColor(cuurentTab == image ? cuurentTab == "circle.fill" ? .white : .black : .gray)
            .frame(maxWidth:.infinity)
        }
    }
}
