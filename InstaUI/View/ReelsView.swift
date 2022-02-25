//
//  ReelsView.swift
//  InstaUI
//
//  Created by shehan karunarathna on 2022-02-25.
//

import SwiftUI
import AVKit

struct ReelsView: View {
    @State var currentReel : String = ""
    @State var reels = MediaJson.map { file -> Reel in
        let url = Bundle.main.path(forResource: file.url, ofType: "mp4") ?? ""
        let player = AVPlayer(url: URL(fileURLWithPath: url))
        return Reel( player:player, mediaFile: file)
    }
    var body: some View {
        GeometryReader{
            proxy in
            let size = proxy.size
            TabView(selection:$currentReel){
                ForEach($reels){
                    $reel in
                    ReelsPlayer(reel: $reel,currenReel: $currentReel)
                    .frame(width:size.width)
                    .padding()
                    .rotationEffect(.init(degrees: -90))
                    .ignoresSafeArea(.all, edges: .top)
                    .tag(reel.id)
                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth:size.width)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.ignoresSafeArea())
        .onAppear {
            currentReel = reels.first?.id ?? ""
        }
    }
}

struct ReelsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReelsPlayer: View {
    @Binding var reel:Reel
    @Binding var currenReel:String
    @State var showMore:Bool = false
    let sampleTxt = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
    @State var isMuted:Bool = false
    @State var showVolumeAnimation:Bool = false
    var body: some View {
        ZStack{
            if let player = reel.player {
                CustomVideoPlayer(player: player)
                GeometryReader{
                    proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size
                    DispatchQueue.main.async {
                        if -minY < (size.height / 2) && minY < (size.height / 2) && currenReel == reel.id{
                            player.play()
                        } else {
                            player.pause()
                        }
                    }
                    return Color.clear
                }
                Color.black.opacity(0.01)
                    .frame(width: 150, height: 150)
                    .onTapGesture {
                        if showVolumeAnimation {
                            return
                        }
                        isMuted.toggle()
                        player.isMuted = isMuted
                        withAnimation {
                            showVolumeAnimation.toggle()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            withAnimation {
                                showVolumeAnimation.toggle()
                            }
                        }
                    }
                Color.black.opacity(showMore ? 0.3 : 0)
                    .onTapGesture {
                        showMore.toggle()
                    }
                VStack{
                    HStack(alignment:.bottom){
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing:15){
                                Image(systemName: "person.circle")
                                    .font(.system(size: 30))
                                    .clipShape(Circle())
                                   
                                
                                Text("Shehan")
                                    .font(.callout.bold())
                                Button{
                                    
                                }label: {
                                    Text("Follow")
                                        .font(.caption.bold())
                                }
                                
                            }
                            ZStack{
                                if showMore {
                                    ScrollView(.vertical, showsIndicators: false) {
                                        Text(reel.mediaFile.title + sampleTxt)
                                            .font(.callout)
                                            .fontWeight(.semibold)
                                    }
                                    .frame(height:120)
                                    .onTapGesture {
                                        showMore.toggle()
                                    }
                                } else {
                                    Button{
                                        withAnimation {
                                            showMore.toggle()
                                        }
                                    }label: {
                                        HStack {
                                            Text(
                                            reel.mediaFile.title)
                                                .font(.callout)
                                                .fontWeight(.semibold)
                                                .lineLimit(1)
                                            Text("more")
                                                .font(.callout.bold())
                                                .foregroundColor(Color.gray)
                                        }
                                    }
                                    .padding(.top, 5)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                                    
                                }
                            }
                            
                        }
                        Spacer(minLength: 20)
                        
                        ActionButtons(reel: reel)
                    }
                    
                    
                    HStack{
                        Text("A sky of full stars")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        Image(systemName: "music.note")
                            .font(.system(size: 15))
                            .padding(10)
                            .background(
                                Circle().stroke(.white,lineWidth: 2)
                            )
                    }
                    .padding(.top,30)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth:.infinity,maxHeight: .infinity, alignment: .bottom)
                
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .clipShape(Circle())
                    .foregroundStyle(.black)
                    .opacity(showVolumeAnimation ? 1 : 0)
            }
            
        }
    }
}

struct ActionButtons: View {
     var reel:Reel
    var body: some View {
        VStack(spacing:25){
            Button{
                
            }label: {
                VStack(spacing:10){
                    Image(systemName: "suit.heart")
                        .font(.title)
                    
                    Text("233K")
                        .font(.caption.bold())
                }
            }
            
            Button{
                
            }label: {
                VStack(spacing:10){
                    Image(systemName: "bubble.right")
                        .font(.title)
                    
                    Text("233")
                        .font(.caption.bold())
                }
            }
            
            Button{
                
            }label: {
                VStack(spacing:10){
                    Image(systemName: "paperplane")
                        .font(.title)
                    
                
                }
            }
            
            Button{
                
            }label: {
                VStack(spacing:10){
                    Image(systemName: "ellipsis")
                        .font(.title)
                    
                
                }
            }
        }
    }
}
