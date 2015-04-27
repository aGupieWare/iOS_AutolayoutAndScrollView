//
//  ViewController.swift
//  Autolayout and Scroll View
//
//  Created by Stefan Agapie on 11/13/14.
//  Copyright (c) 2014 aGupieWare. All rights reserved.
//
//  This file is part of Autolayout and Scroll View.
//
//  Autolayout and Scroll View is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  Autolayout and Scroll View is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with Autolayout and Scroll View.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit

class ViewController: UIViewController {
    
    // Set scroll view height to 35% of root view height //
    let scrollViewHeightAsPercentageOfRootView : CGFloat = 0.36
    // Set scroll view width to 85% of root view width //
    let scrollViewWidthAsPercentageOfRootView : CGFloat = 0.85
    
    let asvScrollView : UIScrollView = UIScrollView(frame: CGRectZero)
    let asvContainerView : UIView = UIView(frame: CGRectZero)
    let asvLeftView : UIView = UIView(frame: CGRectZero)
    let asvMiddleView : UIView = UIView(frame: CGRectZero)
    let asvRightView : UIView = UIView(frame: CGRectZero)

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        // Setup blog name //
        self.asvInstallBlogName()
        
        
        // Setup the scroll view //
        self.asvInstallScrollViewWithoutConstraints()
        
        
        // Setup the scroll view container //
        self.asvInstallScrollViewContainerWithConstraints()
        
        
        // Setup the scroll view container content views //
        self.asvInstallSubviewsInsideTheScrollViewContainerWithConstraints()
        
        
        // -- animate the placements of our auto layout constraints -- //
        // Place the scroll view slightly offset from center before animating //
        self.view.layoutIfNeeded()
        self.asvScrollView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetHeight(self.view.frame)/8.0)
        UIView.animateWithDuration(1.75, animations: { () -> Void in
            // apply custom constraints to our scroll view //
            self.asvApplyHeightAndWidthConstraints()
            self.asvApplyCenteringConstraints()
            self.view.layoutIfNeeded()
        }) { (animated) -> Void in
            // -- animation completion block -- //
            // Once the initial animation is complete we animate the       //
            // contents of the scroll view by changing its content offset. //
            self.asvScrollView.setContentOffset(CGPointMake(CGRectGetMaxX(self.asvLeftView.frame), 0), animated: true)
        }
    }
    
    
    /**
     Installs subviews inside a scroll view container that defines the contents and resizes proportionately to the root view by leveraging autolayout.
    */
    func asvInstallSubviewsInsideTheScrollViewContainerWithConstraints() {
        
        // Prevent system from creating layout constraints //
        self.asvLeftView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.asvMiddleView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.asvRightView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.asvContainerView.addSubview(self.asvLeftView)
        self.asvContainerView.addSubview(self.asvMiddleView)
        self.asvContainerView.addSubview(self.asvRightView)
        
        // Constrain the left subview to the left, top and bottom of its container view //
        let leftTopLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvLeftView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let leftBottomLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvLeftView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let leftLeadingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvLeftView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        // Constrain the left subview's right side to the middle subview's left side so that the two views are touching each other //
        let leftTrailingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvLeftView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.asvMiddleView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        // Constrain the middle subview to the top and bottom of its container view //
        let middleTopLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvMiddleView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let middleBottomLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvMiddleView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        // Constrain the middle subview's right side to the right subview's left side so that the two views are touching each other //
        let middleTrailingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvMiddleView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.asvRightView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        
        // Constrain the right subview to the right, top and bottom of its container view //
        let rightTopLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvRightView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let rightBottomLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvRightView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let rightTrailingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvRightView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.asvContainerView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        
        // add the above constraints to the container view -- the superview of the left, middle and right subviews //
        self.asvContainerView.addConstraints([leftTopLC,leftBottomLC,leftLeadingLC,leftTrailingLC, middleTopLC,middleBottomLC,middleTrailingLC, rightTopLC,rightBottomLC,rightTrailingLC])
        
        // Constrain the left, middle and right subviews so that they all have equal width. //
        // we set the 'multiplier' to 0.99,-slightly widder middle view,- to eliminate a    //
        // a vertical line that appears to the left of the middle view.                     //
        let leftMiddleWidthLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvLeftView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.asvMiddleView, attribute: NSLayoutAttribute.Width, multiplier: 0.99, constant: 0)
        let rightMiddleWidthLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvRightView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.asvMiddleView, attribute: NSLayoutAttribute.Width, multiplier: 0.99, constant: 0)
        
        // Add the width constraints from above //
        self.asvContainerView.addConstraints([leftMiddleWidthLC,rightMiddleWidthLC])
        
        self.asvLeftView.backgroundColor = UIColor.blueColor()
        self.asvMiddleView.backgroundColor = UIColor.yellowColor()
        self.asvRightView.backgroundColor = UIColor.greenColor()
    }
    
    
    /**
    Installs a scroll view without constraints. We delay the installation of the constraints so that we can animate them into place later on in the code.
    */
    func asvInstallScrollViewWithoutConstraints() {
        
        // Set scroll view properteis //
        self.asvScrollView.backgroundColor = UIColor.brownColor()
        self.asvScrollView.bounces = false
        
        
        // Prevent the system from automatically assinging auto layout   //
        // constraints when adding our scroll view to the view hierarchy //
        self.asvScrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.asvScrollView)
    }
    
    
    /**
     Installs a scroll view container that resizes proportionatly to the root view by leveraging autolayout.
    */
    func asvInstallScrollViewContainerWithConstraints() {
        
        // Prevent system from creating layout constraints //
        self.asvContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // The width of the scrollable area is defined as one //
        // and a half times that of the scroll view's width  //
        let widthRatio : CGFloat = 1.5;
        
        // Add the container view and set its constraints so that   //
        // it resizes with the same proportions on screen rotations //
        asvScrollView.addSubview(asvContainerView);
        let topLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        let leadingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let trailingLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        let bottomLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        let widthLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Width, multiplier: widthRatio, constant: 0)
        let heightLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvContainerView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.asvScrollView, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0)
        self.asvScrollView.addConstraints([topLC,leadingLC,trailingLC,bottomLC,widthLC,heightLC])
        
        self.asvContainerView.backgroundColor = UIColor.cyanColor()
    }
    
    
    /** 
     Installs height and width constraints on our scroll view
    */
    func asvApplyHeightAndWidthConstraints() {
    
        let heightLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvScrollView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: self.scrollViewHeightAsPercentageOfRootView, constant: 0)
        let widthLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvScrollView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Width, multiplier: self.scrollViewWidthAsPercentageOfRootView, constant: 0)
        self.view.addConstraints([heightLC,widthLC])
    }
    
    
    /**
     Installs centering constraints on our scroll view
    */
    func asvApplyCenteringConstraints() {
        
        let centerXLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvScrollView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        let centerYLC : NSLayoutConstraint = NSLayoutConstraint(item: self.asvScrollView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        self.view.addConstraints([centerXLC,centerYLC])
    }
    
    
    /**
     Installs label with blog name
    */
    func asvInstallBlogName() {
        
        let blogLabel : UILabel = UILabel()
        let topLC : NSLayoutConstraint = NSLayoutConstraint(item: blogLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 64)
        let leftLC : NSLayoutConstraint = NSLayoutConstraint(item: blogLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        let rightLC : NSLayoutConstraint = NSLayoutConstraint(item: blogLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        blogLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(blogLabel)
        self.view.addConstraints([topLC,leftLC,rightLC])
        
        blogLabel.textAlignment = NSTextAlignment.Center
        blogLabel.textColor = UIColor.darkGrayColor()
        blogLabel.text = "aGupieWare"
        blogLabel.font = UIFont(name: "Helvetica-Bold", size: 26)
    }
}

