//
//  ViewController.swift
//  SingleCellPagingTest
//
//  Created by Candy on 1/9/16.
//  Copyright © 2016 jon-1. All rights reserved.
//

import UIKit
class CustomCell : UICollectionViewCell {
    var imageView : UIImageView
    var focusable : Bool = true
    required init?(coder aDecoder: NSCoder) {
        self.imageView = UIImageView()
        super.init(coder: aDecoder)
        imageView.adjustsImageWhenAncestorFocused = true
        //self.imageView.frame = self.frame
       // self.addSubview(imageView)
    
        
    }
    
    override init(frame: CGRect) {
        self.imageView = UIImageView(frame: frame)
        super.init(frame: frame)
        self.addSubview(self.imageView)
        imageView.adjustsImageWhenAncestorFocused = true
    }
    
    override func canBecomeFocused() -> Bool {

        return focusable
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.registerClass(CustomCell.self, forCellWithReuseIdentifier: "cell")
        print(collectionView.decelerationRate)
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.contentOffset = CGPointMake(0, 0)
        
       // let decelerationRate = UIScrollViewDecelerationRateFast + (UIScrollViewDecelerationRateNormal - UIScrollViewDecelerationRateFast) - 80;
        // collectionView.setValue(NSValue.init(CGSize: CGSizeMake(decelerationRate, decelerationRate)), forKey: "_decelerationFactor")
           print(collectionView.decelerationRate)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CustomCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.imageView.frame = cell.bounds
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.redColor()
                    cell.imageView.image = UIImage(named:"pizzahut200px")
              cell.focusable = true
        } else if indexPath.row % 3 == 0 {
            cell.backgroundColor = UIColor.orangeColor()
                    cell.imageView.image = UIImage(named:"pizzahut200px")
                cell.focusable = true
        } else {
            cell.backgroundColor = UIColor.grayColor()
                    cell.imageView.image = UIImage(named:"pizzahut200px")
                cell.focusable = true
        }

        return cell
    }
    
    func indexPathForPreferredFocusedViewInCollectionView(collectionView: UICollectionView) -> NSIndexPath? {

        return collectionView.indexPathsForVisibleItems().last
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let focusedCell = UIScreen.mainScreen().focusedView as! CustomCell
        if let jPath = collectionView.indexPathForCell(focusedCell) {
              UIView.animateWithDuration(0.30, animations: {
             self.collectionView.scrollToItemAtIndexPath(jPath, atScrollPosition: .CenteredVertically, animated: false)
                
            })
        
        }
    }
}

