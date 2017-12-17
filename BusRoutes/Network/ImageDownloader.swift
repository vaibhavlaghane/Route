//
//  ImageDownloader.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//


import UIKit


/// NSoperation to download image 
class ImageDownloader: Operation {
    
    var  route: Route
    var  imageData: Data? = nil
    
    init(route : Route) {
        self.route = route 
    }
 
    override func main() {
        
        if self.isCancelled   {
            return
        } 
        if let imgURL = self.route.imageURL{
            imageData =   try? Data(contentsOf: imgURL)
           
        }else{
            route.isImageDownloaded = .Failed
            return
                //log - imageURL is nil, cannot download the image
        }
        if imageData != nil { 
            self.route.save(   imageData!)
            self.route.isImageDownloaded = .Downloaded
        }
        else
        {
            self.route.isImageDownloaded = .Failed
            self.route.imageData = UIImage(named: "Failed")
        }
    }
    
}
