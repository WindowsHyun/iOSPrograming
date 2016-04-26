//
//  CustomScrollViewController.swift
//  ScroolViews
//
//  Created by HyunWindows on 2016. 4. 26..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class CustomScrollViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView :UIScrollView!

    var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let containerSize = CGSize(width: 640.0, height: 640.0)
        containerView = UIView(frame: CGRect(origin: CGPoint(x:0, y:0), size:containerSize))
        scrollView.addSubview(containerView)
        
        let redView = UIView(frame:CGRect(x:0, y:0, width: 640, height:80))
        redView.backgroundColor = UIColor.redColor();
        containerView.addSubview(redView)
        
        let blueView = UIView(frame: CGRect(x:0, y:560, width: 640, height: 80))
        blueView.backgroundColor = UIColor.blueColor();
        containerView.addSubview(blueView)
        
        let grennView = UIView(frame: CGRect(x:160, y:160, width: 320, height: 320))
        grennView.backgroundColor = UIColor.greenColor();
        containerView.addSubview(grennView)
        
        let imageView = UIImageView(image: UIImage(named:"slow.png"))
        imageView.center = CGPoint(x:320, y:320);
        containerView.addSubview(imageView)
        
        scrollView.contentSize = containerSize;
        
        let scrollViewFrame = scrollView.frame
        let scaleWidth = scrollViewFrame.size.width / scrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / scrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = 1.0
        
        centerScrollViewContents()
        
    }
    
    func centerScrollViewContents(){
        let boundsSize = scrollView.bounds.size
        var contentsFrame = containerView.frame
        //이미지 크기가 화면크기보다 작으면 이미지 origin(top,left)위치를 약간 가운데로 옮김
        if contentsFrame.size.width < boundsSize.width{
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width)/2.0
        }else{ // 이미지가 화면보다 크면 무조건 (0,0)에서 시작
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height{
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        }else{
            contentsFrame.origin.y = 0.0
        }
        containerView.frame = contentsFrame
    }


}
