//
//  CustomCollectionViewFlowLayout.swift
//  VerticalCellPagingTest
//
//  Created by Candy on 1/9/16.
//  Copyright © 2016 jon-1. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func awakeFromNib() {

    self.itemSize = CGSizeMake(300.0, 200.0);
    self.minimumInteritemSpacing = 100.0;
    self.minimumLineSpacing = 100.0;
    self.scrollDirection = .Vertical;
    self.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    self.headerReferenceSize = CGSizeMake(0, 500.0)
    }
    
    
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if proposedContentOffset.y > self.collectionViewContentSize().height - 320 - self.sectionInset.bottom {
        return proposedContentOffset;
        }
        var offsetAdjustment : CGFloat = CGFloat(MAXFLOAT)
        let verticalOffset : CGFloat = proposedContentOffset.y
        let targetRect : CGRect = CGRectMake(0, proposedContentOffset.y, CGRectGetWidth(self.collectionView!.bounds), CGRectGetHeight(self.collectionView!.bounds))
        let ar  = super.layoutAttributesForElementsInRect(targetRect)!
        
        for var lAttributes : UICollectionViewLayoutAttributes in ar {
            let itemOffset : CGFloat = lAttributes.frame.origin.y
            if abs(itemOffset - verticalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - verticalOffset
            }
        }
        
        let returnPoint = CGPointMake(proposedContentOffset.x , proposedContentOffset.y + offsetAdjustment)
        
        return returnPoint
    }
    
//    - (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//    {
//    CGFloat offsetAdjustment = MAXFLOAT;
//    CGFloat horizontalOffset = proposedContentOffset.x + 5;
//    
//    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
//    
//    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
//    
//    for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
//    CGFloat itemOffset = layoutAttributes.frame.origin.x;
//    if (ABS(itemOffset - horizontalOffset) < ABS(offsetAdjustment)) {
//    offsetAdjustment = itemOffset - horizontalOffset;
//    }
//    }
//    
//    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
//    }
}
