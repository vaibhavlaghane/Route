//
//  BusRoutesTests.swift
//  BusRoutesTests
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import XCTest
@testable import BusRoutes

class BusRoutesTests: XCTestCase {
    
    var netCall:DataDownloader? = nil
    var routes: [Route ]? = nil
    var netOps: NetworkOperationManager? = nil
    var imageLink: String =  "http://www.freepngimg.com/thumb/bus/1-bus-png-image-thumb.png"
    
    
    override func setUp() {
        super.setUp()
        netCall = DataDownloader()
        netOps = NetworkOperationManager()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testURLCreation(){
        let url = netCall?.createURLFromParameters()
        XCTAssertNotNil(url)
        print(url ?? " ");
    }
    
    func testNetworkCall(){
        let expectation = self.expectation(description: "fetch posts") 
        netCall?.getJSONData(   completion: { (arr ) in
            XCTAssertNotNil(arr)
            print(arr  ?? "")
            expectation.fulfill()
        },failure: {( response, error) in
            //
        })
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testgetRoute(){
        let expectation = self.expectation(description: "fetch route")
        netCall?.getJSONData(   completion: { (arry ) in
            XCTAssertNotNil(arry)
            print(arry ?? "")
            self.routes = Utility.parseJSON(arry : arry)
            let route  = self.routes![0] as? Route
            //XCTAssertEqual(route?.routeId, self.pID)
            expectation.fulfill()
        },failure: {( response, error) in
            //
        })
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetImage(){
        
    }
    
    func testimageDownloader(){
        var imageData: Data? = nil
        if let imgURL =   URL.init(string: imageLink) {
            imageData =   try? Data(contentsOf: imgURL)
        }
        XCTAssertNotNil(imageData)
    }
    
    func testImageSave(){
//        let route = self.routes![0]
//        if (route.imageData != nil){
//            //route.save(route.imageData)
//        }
    }
    
}
