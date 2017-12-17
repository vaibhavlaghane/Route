//
//  ViewController.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//


import UIKit

enum ImageDownLoadState:String  {
    case New
    case Downloaded
    case InProgress
    case Failed
}

class Route: NSObject {

    var routeId: String?{
        didSet{
            if( routeId != nil ){
                let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
                let url = URL(fileURLWithPath: path).appendingPathComponent(routeId!)
                imageFileURL =  url
            }
        }
    }
    var stopName: String?
    var shortDescription: String? 
    var isAccessible: Bool?
  
    var stopsList: Array<String>?
    var imageData: UIImage?
    var isImageDownloaded: ImageDownLoadState = .New 
    
    var imageURL: URL? = nil 
    var imagelink: String?{
        didSet{
            if( imagelink != nil ){
                imageURL = URL.init(string: imagelink!)
            }
        }
    }
    
    var imageFileURL: URL? = nil
    
     init(routeId: String?,
          stopName: String?,
          description: String?,
          imagelink: String?,
          stopsList: Array<String>?,
          isAccessible: Bool?)
     {
        self.routeId = routeId ?? ""
        self.stopName = stopName ?? ""
        self.shortDescription = description ?? ""
        self.isAccessible = isAccessible  ?? false
        self.stopsList = stopsList ?? []
        self.imagelink = imagelink ?? ""
        
        if( self.imagelink != nil ){
            imageURL = URL.init(string: self.imagelink!)
        }
        
    }
    
    /// Save image to file
    ///
    /// - Parameter imageData: image downloaded as data from URL location
    func save( _ imageData: Data ) {
     
        if( routeId != nil ){
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let url = URL(fileURLWithPath: path).appendingPathComponent(routeId!)
            imageFileURL =  url
        }else{ 
            let pathCom = imageURL?.path
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let url = URL(fileURLWithPath: path).appendingPathComponent(pathCom!)
            imageFileURL =  url
        }
        try! imageData.write(to: imageFileURL!)
       // print("saved image at \(imageFileURL!)")
         
 
    }
    
    
    /// Retrieve the image saved to file location
    ///
    /// - Returns: UIImage
    func getImage()->UIImage? {
        var img: UIImage? = nil
        if let imgURL = self.imageFileURL{
            if let  data =   try? Data(contentsOf: imgURL){
            imageData =  UIImage(data:data)
            }
        }
        img = imageData
        return img
    }
    
    
}
