//
//  DataDownloader.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//


import UIKit

struct Constants {
    struct APIDetails {
        static let APIScheme = "http"
        static let APIHost = "www.mocky.io"
        static let APIPath = "/v2/5a0b474a3200004e08e963e5"
    }
}

/// Data downloader class
class DataDownloader: NSObject {
    
    /// function call to get JSON data
    /// completion block handles the received JSON
    /// - Returns: none
    internal func getJSONData(  completion: @escaping (Array<Any?>? ) -> Void , failure: @escaping (URLResponse? , Error? ) -> Void  )->Void   {
        
        let urlUsr = createURLFromParameters(  ) ;
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: urlUsr  )
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        session.dataTask(with: request as URLRequest){(data: Data?,response: URLResponse?, error: Error?) -> Void in
            if let responseData = data
            {
                do{
                    let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.allowFragments)
                    //print(json)
                    completion(json as?  Array<Any?> )//Dictionary<String, Any >)
                }catch{
                    print("Could not serialize")
                    completion(nil)
                }
            }
            }.resume()
    }

    ///  function to create URL using the paramenters
    ///
    /// - Returns: url  for data download
    internal func createURLFromParameters() -> URL {
        
        var components      = URLComponents()
        components.scheme   = Constants.APIDetails.APIScheme
        components.host     = Constants.APIDetails.APIHost
        components.path     = Constants.APIDetails.APIPath
        
        return components.url!
    }
}
