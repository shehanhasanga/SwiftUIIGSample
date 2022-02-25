//
//  MediaFile.swift
//  InstaUI
//
//  Created by shehan karunarathna on 2022-02-25.
//

import Foundation

struct MediaFile:Identifiable{
    var id:String = UUID().uuidString
    var title:String
    var url:String
    var isExpanded:Bool = false
}

var MediaJson :[MediaFile] = [
    MediaFile(title: "Apple air tag", url: "file1"),
    MediaFile(title: "Brand New apple tower is opened", url: "file1"),
    MediaFile(title: "SponserShip", url: "file1"),
    MediaFile(title: "Apple air tag new one is released", url: "file1"),

]
