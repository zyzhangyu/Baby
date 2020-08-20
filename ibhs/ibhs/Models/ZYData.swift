//
//  ZYData.swift
//  ibhs
//
//  Created by developer on 2020/8/20.
//  Copyright © 2020 developer. All rights reserved.
//

import UIKit
import SwiftUI
import CoreLocation

let landmarkData: [Landmark] = load("landmarkData.json")

func load<T:Decodable>(_ filename:String) -> T {
    
    let data:Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Could not find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename) from main bundle: \n \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Coul not parse \(filename) as \(T.self):\n\(error)")
    }
}

final class ImageStore {
    ///字典 通过字符串 查找图片
    typealias _ImageDictionary = [String: CGImage]
    
    ///空字典 存放images
    fileprivate var images: _ImageDictionary = [:]
    
    ///缩放比例
    fileprivate static var scale = 2
    
    ///类常量单例
    static var shared = ImageStore()
    
    ///通过名字返回图片
    func image(name:String) -> Image {
        let index = _guaranteeImage(name: name)
        
        return Image(images.values[index], scale: CGFloat(ImageStore.scale), label: Text(name))
    }
    
    
    
    fileprivate func _guaranteeImage(name: String) -> _ImageDictionary.Index {
        
        ///如果images里面存在这张图片 就返回index
        if let index = images.index(forKey: name) {
            return index
        }
        
        ///images里没有这张图片 就从硬盘里拿
        ///images[name] 得到的应该是一个键值对  {key:value}
        images[name] = ImageStore.loadImage(name: name)
        return images.index(forKey: name)!
    }
    
    
    ///根据图片名从文件夹中获取文件
    static func loadImage(name:String) -> CGImage {
        guard
            let url = Bundle.main.url(forResource: name, withExtension: "jpg"),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            fatalError("Could not load image \(name).jpg from main Bundle.")
        }
        return image
    }
}


struct ZYData_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
