//
//  ScrollViewContainer.swift
//  ScroolViews
//
//  Created by HyunWindows on 2016. 4. 28..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {

    @IBOutlet var scrollView: UIScrollView!
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent!) -> UIView?{
        let view = super.hitTest(point, withEvent: event)
        if let theView = view{
            if theView == self{
                return scrollView
            }
        }
        return view
    }

}
