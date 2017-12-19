//
//  Utility.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import UIKit

class Utility: NSObject {
    
    /// parse the json
    /// - Parameter arry: input json array
    /// - Returns: array of route object
    static func parseJSON(arry: Array< Any>?)-> [Route ] {
    
        guard let jsonArr   = arry  else{return [] }
        if jsonArr.count == 0 { return [] }
         var routes = [Route]()
        
        for (_,element) in jsonArr.enumerated(){
            
            if  let route  = element as? Dictionary< String, Any>{

                let routeId = route["id"] ?? ""
                let stopName = route["name"] ?? ""
                let description = route["description"] ?? ""
                let imagelink = route["imageUrl"] ?? ""
                let stopsDictionaryList: Array<Dictionary< String, Any? >> = (route["stops"]   as? Array<Dictionary<String, Any?>>)!
                var stopsList = Array<String >()
                
                for(_ , element) in stopsDictionaryList.enumerated(){
                    stopsList.append(element["name"] as! String)
                }
                
                var isAccessible = false
                if let  accessibleStr =  route["accessible"]  as? Bool{
                    isAccessible = accessibleStr
                }
                
                let route  = Route(routeId: routeId as? String,
                                   stopName: stopName as? String,
                                   description: description as? String,
                                   imagelink: imagelink as? String,
                                   stopsList: stopsList ,//as?  Array<String>,
                                   isAccessible: isAccessible )//as? Bool)
                
                routes.append(route )
          
            }
        }
        
        
        
        return routes
    }
    
    /// ALert message dislay
    ///
    /// - Parameters:
    ///   - message: message string
    ///   - title: Title of message
    ///   - completion: completion block
    class func showAlertMessage(_ message: String, withTitle title: String, onClick completion: @escaping () -> Void) {
        let alert = UIAlertController(title: " \(title)", message: message, preferredStyle: .alert)
        //Add Buttons
        let okButton = UIAlertAction(title: "Ok", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            //Handle button action here
            completion()
        })
        alert.addAction(okButton)
        
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alert, animated: true, completion: nil)
    }
}
