//
//  RouteDetailCollectionViewController.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import UIKit

private let kReuseIdentifier = "routeCollectionViewCell"

class RouteCollectionViewController: UIViewController {

      var routesList = [Route ]()
      var route :Route? = nil
    private var currentIndex =  0
    private var selfViewWidth: CGFloat = 0
    private var cellWidth: CGFloat = 0
    private var cellHeight: CGFloat = 0
    private var initialIndex = false
    
    @IBOutlet weak var collectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Register cell classes
        self.collectionView.register(UINib(nibName: "RouteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kReuseIdentifier)

        selfViewWidth = self.view.frame.size.width
        cellHeight = self.view.frame.size.height
        
        let rIndex  = routesList.index(of: route!)
        currentIndex = rIndex!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        for route in routesList{
            route.imageData = nil
        }
    }
  
    /// method to swipe view and load new view based on the scroll
    ///
    /// - Parameters:
    ///   - scrollView: UIScrollView
    ///   - velocity: velocity
    ///   - targetContentOffset: targetContentOffset
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let  pageWidth: CGFloat =    selfViewWidth
        let  currentOffset = scrollView.contentOffset.x;
        var  toffset = targetContentOffset.pointee
        let  targetOffset =  toffset.x;
        var  newTargetOffset = 0;
        
        if (targetOffset > currentOffset){
            newTargetOffset = Int(ceilf( Float(CGFloat( currentOffset) / (pageWidth  ) )) * Float(pageWidth));
            currentIndex = currentIndex + 1
        }else{
            newTargetOffset = Int(floorf(Float(currentOffset / (pageWidth   ) )) * Float(pageWidth));
            currentIndex = currentIndex - 1
        }
        
        if (newTargetOffset < 0){
            newTargetOffset = 0;
        }else if ( CGFloat( newTargetOffset)  > scrollView.contentSize.width){
            newTargetOffset = Int(scrollView.contentSize.width);
        }
        
        toffset.x = currentOffset;
        scrollView.setContentOffset( CGPoint.init(x: CGFloat( newTargetOffset) , y: 0)   , animated: true)
 
    }
 

 }


// MARK: - UICollectionViewDataSource
extension RouteCollectionViewController: UICollectionViewDataSource {
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return routesList.count
    }
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kReuseIdentifier, for: indexPath) as? RouteCollectionViewCell{
            let route = routesList[indexPath.row]
            if let stopName = route.stopName{
            cell.stopName?.text = stopName
            }
            if let shortDescription =  route.shortDescription{
            cell.shortDescription.text =  shortDescription
            }
            
           // let _ = route.getImage()
            if let image = route.imageData{
            cell.imageVIew.image = image
            }
            cell.accessibilityImage.isHidden = route.isAccessible!
            // Configure the cell
            cell.route = route 
            return  cell
        }
        return UICollectionViewCell()
        
    }

}

// MARK: - UICollectionViewDelegate
extension RouteCollectionViewController: UICollectionViewDelegate {
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        for route in routesList{
            
            route.imageData = nil 
        }
        
        if indexPath.row < routesList.count{
            let route = routesList[indexPath.row]
            _ = route.getImage()
            
            if indexPath.row + 1 < routesList.count{
                let route = routesList[indexPath.row + 1 ]
                _ = route.getImage()
            }
            if (indexPath.row - 1 >= 0) {
                let route = routesList[indexPath.row - 1 ]
                _ = route.getImage()
                
            }
        }
        
        
        if !initialIndex {
            let indexToScrollTo = IndexPath(item: currentIndex, section: 0)
            self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            initialIndex = true
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
//      //  <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        //<#code#>
//    }
    
    //func collec
}


