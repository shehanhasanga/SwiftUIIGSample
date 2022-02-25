//
//  CustomVideoPlayer.swift
//  InstaUI
//
//  Created by shehan karunarathna on 2022-02-25.
//

import Foundation
import SwiftUI
import AVKit

struct CustomVideoPlayer:UIViewControllerRepresentable{
    let player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspect
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator:NSObject{
        var parent:CustomVideoPlayer
        init(parent : CustomVideoPlayer) {
            self.parent = parent
        }
        @objc func restartPlayback(){
            parent.player.seek(to: .zero)
        }
    }
}
