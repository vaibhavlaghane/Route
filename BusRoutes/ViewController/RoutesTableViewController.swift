//
//  RoutesTableViewController.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import UIKit

let kRouteCellIdentifier = "routeCell"

class RoutesTableViewController: UITableViewController {

    var routeList = [Route]()
    var netOp = NetworkOperationManager()
    
    var flagHideLoadingView         = true
    var loadingView:LoadingView     = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoadingIndicator(start:  true )

        netOp.downloadData() { (routes ) in
            self.routeList =  routes!
            
            DispatchQueue.main.async {
                self.setupLoadingIndicator(start:  false )
                self.tableView.reloadData()
            }
        }
        self.tableView.estimatedRowHeight =   UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 55.0;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        for route in routeList{
            route.imageData = nil
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeList.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellR = tableView.dequeueReusableCell(withIdentifier: kRouteCellIdentifier, for: indexPath) as? RouteCell

        if let cell = cellR{
            //cell.textLabel?.text = routeList[indexPath.row].stopName
            let route = routeList[indexPath.row]
            if let name = route.stopName{
                cell.labelRoute.text = name
            }
            let _  = route.getImage()
            if let image = route.imageData {
                cell.imageBus.image = image
            }
        // Configure the cell...
        return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: kRouteCellIdentifier)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: kshowCollectionViewdentifier, sender: indexPath);
    }
    
    /*
     MARK: - Navigation
     In a storyboard-based application, you will often want to do a little preparation before navigation  */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == kshowCollectionViewdentifier){
            
            let destViewController                  =   segue.destination as! RouteCollectionViewController
            let indexPath = sender as? IndexPath
            destViewController.route           =   routeList[(indexPath?.row)!]
            destViewController.routesList = routeList

        }
    }
    
    
    /// method to start or stop loading indicator
    ///
    /// - Parameter start: true or false to start or stop loading
    func setupLoadingIndicator(start: Bool ){
        if(start){
            var flagSubviewPresent = false
            
            for view in self.view.subviews{
                if view === self.loadingView {
                    DispatchQueue.main.async {
                        self.loadingView.isHidden = false
                        self.flagHideLoadingView = false
                    }
                    flagSubviewPresent = true
                    break
                }
            }
            if(!flagSubviewPresent ){
                self.loadingView = LoadingView(frame: self.view.frame)
                self.view.addSubview(self.loadingView)
                DispatchQueue.main.async {
                    self.loadingView.isHidden = false
                    self.flagHideLoadingView = false
                }
            }
        }
        else if(!start ){
            DispatchQueue.main.async {
                self.loadingView.stopSpinner()
                self.loadingView.isHidden  = true
                self.flagHideLoadingView = true
            }
        }
    }
    

}
