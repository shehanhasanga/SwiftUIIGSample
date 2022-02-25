//
//  Reel.swift
//  InstaUI
//
//  Created by shehan karunarathna on 2022-02-25.
//

import Foundation
import AVKit

struct Reel :Identifiable{
    var id:String = UUID().uuidString
    var player:AVPlayer?
    var mediaFile :MediaFile
    
}
