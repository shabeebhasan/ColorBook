//
//  FloodFillingImageView.swift
//  colorbook
//
//  Created by Shabeeb Hasan on 04/06/2016.
//  Copyright © 2016 Shabeeb Hasan. All rights reserved.
//

import UIKit

class FloodFillingImageView: UIImageView {
    
    var newcolor: UIColor!
    var multiplierCGPoint: CGPoint!
    var originalImage: String!
    

    /*override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            let printPoint = getCalculatedPoint(touch.locationInView(self))
            
            if(originalImage == nil){
                originalImage = self.image
            }
            
            let result = self.image!.floodFillFromPoint(printPoint, withColor: self.newcolor, andTolerance: 10)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //print("setting image to UIImageView")
                 //[self setImage:image1];
                if(result != nil){
                    self.image = result
                }
            })
        }
    }*/
    
    func fillColor(_ tapPoint: CGPoint){
        let printPoint = getCalculatedPoint(tapPoint)
        
        let result = self.image!.floodFill(from: printPoint, with: self.newcolor, andTolerance: 14,originalImage: UIImage(named: originalImage))
        
        DispatchQueue.main.async(execute: { () -> Void in
            //print("setting image to UIImageView")
            //[self setImage:image1];
            if(result != nil){
                self.image = nil
                self.image = result
            }
        })
    }
    
    func setmultiplierCGPoint(){
        let v = self as UIView
        let viewWidth = Float(v.frame.width)
        let viewHeight = Float(v.frame.height)
        
        print("imageview size: width = ",viewWidth)
        print("imageview size: height = ",viewHeight)
        
        let imageWidth = Float(self.image!.size.width)
        let imageHeight = Float(self.image!.size.height)
        
        print("image size: height = ",imageWidth)
        print("image size: width = ",imageHeight)
        
        if(self.multiplierCGPoint == nil){
            self.multiplierCGPoint = CGPoint(x: CGFloat(imageWidth/viewWidth), y: CGFloat(imageHeight/viewHeight))
        }
    }
    
    func getCalculatedPoint(_ point: CGPoint) -> CGPoint{
        
        if(self.multiplierCGPoint == nil){
            self.setmultiplierCGPoint()
        }
        
        let printPoint =  CGPoint(x: CGFloat(Float(multiplierCGPoint.x) * Float(point.x)) , y: CGFloat(Float(multiplierCGPoint.y) * Float(point.y)))
        
        //print("printPointX = ",printPoint.x)
        //print("printPointY = ",printPoint.y)
        
        return printPoint
    }

}
