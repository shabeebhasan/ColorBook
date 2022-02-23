//
//  ViewController.swift
//  colorbook
//
//  Created by Shabeeb Hasan on 03/06/2016.
//  Copyright © 2016 Shabeeb Hasan. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate{

    @IBOutlet var imageView: FloodFillingImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var textField: UITextField!
    
    var colors = [0xf7aec2, 0xef2b75, 0xef3125, 0x7eb0cb,0x008080] as [Any]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.newcolor = UIColor(netHex:colors[0] as! Int)
        self.setupNavigationBar()
        self.collectionView.backgroundColor = UIColor.clear
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 12
        scrollView.zoomScale = 1
        self.setRandomImage()        
    }
    
    func setRandomImage(){
        var randomNumber = Int(arc4random_uniform(5))
        
        switch(randomNumber){
        case 0:
            self.imageView.image = UIImage(named: "mandala.png")
            self.imageView.originalImage = "mandala.png"
            break
        case 1:
            self.imageView.image = UIImage(named: "tiger.png")
            self.imageView.originalImage = "tiger.png"
            break
        case 2:
            self.imageView.image = UIImage(named: "butterfly.png")
            self.imageView.originalImage = "butterfly.png"
            break
        case 3:
            self.imageView.image = UIImage(named: "owl.png")
            self.imageView.originalImage = "owl.png"
            break
        default:
            randomNumber = Int(arc4random_uniform(4))
            switch(randomNumber){
            case 0:
                self.imageView.image = UIImage(named: "mandala.png")
                self.imageView.originalImage = "mandala.png"
                break
            case 1:
                self.imageView.image = UIImage(named: "tiger.png")
                self.imageView.originalImage = "tiger.png"
                break
            case 2:
                self.imageView.image = UIImage(named: "butterfly.png")
                self.imageView.originalImage = "butterfly.png"
                break
            case 3:
                self.imageView.image = UIImage(named: "owl.png")
                self.imageView.originalImage = "owl.png"
                break
            default:
                self.imageView.image = UIImage(named: "mandala.png")
                self.imageView.originalImage = "mandala.png"
                break
            }

            break
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        self.imageView.layoutIfNeeded()
        self.imageView.setmultiplierCGPoint()
    }
    
    @IBAction func imagetapAction(_ sender: UITapGestureRecognizer) {
        if(sender.state == .ended) {
            let point = sender.location(in: self.imageView)
            //print("point.x = ", point.x)
            //print("point.y = ", point.y)
            self.imageView.fillColor(point)
        }
    }
    
    // MARK: UIScrollViewDelegate
    func viewForZooming(in view: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func setupNavigationBar(){
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            let navigationSeparator = UIView(frame: CGRect(x: 18, y: CGFloat(navigationBar.frame.size.height - 2.5), width: navigationBar.frame.size.width - 36, height: CGFloat(2)))
            navigationSeparator.backgroundColor = UIColor(netHex:0x999999)
            navigationSeparator.isOpaque = true
            self.navigationController?.navigationBar.addSubview(navigationSeparator)
        }
        
        var btnName = UIButton()
        btnName.setImage(UIImage(named: "back"), for: UIControl.State())
        btnName.frame = CGRect(x: 18, y: 0, width: 22, height: 28)
        btnName.addTarget(self, action: #selector(ViewController.backBtnPressed(_:)), for: .touchUpInside)
        
        //.... Set Left Bar Button item
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = btnName
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        btnName = UIButton()
        btnName.setImage(UIImage(named: "more-icon"), for: UIControl.State())
        btnName.frame = CGRect(x: -18, y: 0, width: 45, height: 20)
        btnName.addTarget(self, action: #selector(ViewController.backBtnPressed(_:)), for: .touchUpInside)
        
        //.... Set Right Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        
        let buttonView =  UIView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(named: "undo-icon"), for: UIControl.State())
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let btn2 = UIButton()
        btn2.setImage(UIImage(named: "redo-icon"), for: UIControl.State())
        btn2.frame = CGRect(x: 70, y: 0, width: 30, height: 30)
        
        buttonView.addSubview(btn1)
        buttonView.addSubview(btn2)
        
        self.navigationItem.titleView = buttonView;
    }
    
    @objc func backBtnPressed(_ sender: UIButton){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color_cell", for: indexPath) as! ColorCollectionViewCell
        
        if(self.colors[indexPath.item] as? String == "last"){
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "add_color_cell", for: indexPath) as! ColorCollectionViewCell
            //cell.layer.cornerRadius = 25;
        }else{
            cell.backgroundColor = UIColor(netHex: self.colors[indexPath.item]as! Int)
            cell.layer.cornerRadius = 25
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        if(self.colors[indexPath.item] as? String != "last"){
            self.imageView.newcolor = UIColor(netHex: self.colors[indexPath.item]as! Int)
        }
    }
}

