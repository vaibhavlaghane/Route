//
//  RouteCollectionViewCell.swift
//  BusRoutes
//
//  Created by vlaghane on 12/15/17.
//  Copyright © 2017 Wlabs. All rights reserved.
//

import UIKit

class RouteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shortDescription: UITextView!
    @IBOutlet weak var stopName: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var accessibilityImage: UIImageView!
    @IBOutlet weak var routeListView: UIScrollView!
    
    private var stopsList:  [String]?
     var route:Route?{
        
        didSet{
            
            stopsList = route?.stopsList
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        
        let subviews = self.routeListView.subviews
        for subView in subviews{
            subView.removeFromSuperview()
        }
        
     
        let dotWidth = 25
        let dotHeight = 48
        let dotx = 7
        let doty = 67
        let yTop = 12
        
        let xline = 17
        let yLineTop = 35
        let lineHeight = 67
        let lineWidth = 5
       
        let labelX = 45
        let labelYTop = 23
        let labelY = 67
        let labelWidth =  self.routeListView.frame.width - 100// 250
        let labelHeight = 25
        
        if let list = stopsList{
            
            let rW =  self.routeListView.contentSize.width
            self.routeListView.contentSize = CGSize(width: rW, height: CGFloat( list.count*70 ))
//            self.routeListView.
            
            for (index ,stopName) in list.enumerated(){
                let y = yTop + doty*index
                let x = dotx
                let imageview:UIImageView=UIImageView(frame: CGRect(x: x, y: y , width: dotWidth, height: dotHeight))
                let image:UIImage = UIImage(named:"primitive-dot.png")!
                imageview.image = image
                self.routeListView.addSubview(imageview)
     
                let yLabel = labelYTop + labelY*index
                let xLabel = labelX
                let labelName: UILabel = UILabel(frame: CGRect(x: xLabel, y: yLabel, width: Int(labelWidth), height: labelHeight)   )
                labelName.text = stopName
                self.routeListView.addSubview(labelName)
                
                if( index < list.count - 1 ){
                    let yL = yLineTop + lineHeight*index
                    let xL = xline
                    let imageviewLine:UIImageView=UIImageView(frame: CGRect(x: xL, y: yL , width: lineWidth, height: lineHeight))
                    let imageLine:UIImage = UIImage(named:"line.png")!
                    imageviewLine.image = imageLine
                    self.routeListView.addSubview(imageviewLine)
                }
            }
        }
        
       
    }
}
