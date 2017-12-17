//
//  NetworkOperationManager.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import UIKit

class PendingOperations {
    lazy var downloadsInProgress = [Int:Operation]()
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

/// network operations manager class
class NetworkOperationManager: NSObject {
    
    let downloader = DataDownloader()
    var routes = [Route]()
    let pendingOperations = PendingOperations()
    
    /// download JSON data for given page and size
    ///
    ///   - completion: completion block 
    func downloadData(   completion: @escaping ([Route]? ) -> Void )->Void{
        downloader.getJSONData(  completion: { (arry) in
            
            let routeList = Utility.parseJSON(arry: arry ?? [])
            self.routes.append(contentsOf:routeList  )
            
            completion(routeList)
            
            for (index, element) in self.routes.enumerated(){
                self.startDownloadRouteImage(route : element, index: index )
            }
        }) { (response, error) in   //
            
            Utility.showAlertMessage("Failed to Download the Content", withTitle: "Download Update", onClick: {
                
                NSLog(error as! String)
            })
                
            NSLog(error as! String)
        }
    }
    
    /// method starts the image download operation on the OperationQueue
    
    /// - Parameters:
    ///   - route: route
    ///   - index: index of route 
    func startDownloadRouteImage(route : Route, index: Int){
        
        if let _ = pendingOperations.downloadsInProgress[index ] {
            return
        }
        let downloader = ImageDownloader(route : route )
        
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: index )
            }
        }

        pendingOperations.downloadsInProgress[index ] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
