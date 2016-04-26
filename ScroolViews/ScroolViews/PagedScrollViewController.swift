//
//  PagedScrollViewController.swift
//  ScroolViews
//
//  Created by HyunWindows on 2016. 4. 26..
//  Copyright © 2016년 HyunWindows. All rights reserved.
//

import UIKit

class PagedScrollViewController: UIViewController, UIScrollViewDelegate{
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []
    var pageViews: [UIImageView?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageImages = [UIImage(named:"photo1.png")!,
                      UIImage(named:"photo2.png")!,
                      UIImage(named:"photo3.png")!,
                      UIImage(named:"photo4.png")!,
                      UIImage(named:"photo5.png")!]
        let pageCount = pageImages.count
        pageControl.currentPage = 0
        pageControl.numberOfPages = pageCount
        
        for _ in 0..<pageCount{
            pageViews.append(nil)
        }
        
        let pagesScrollViewSize = scrollView.frame.size
        scrollView.contentSize = CGSize(width: pagesScrollViewSize.width * CGFloat(pageImages.count),
                                        height: pagesScrollViewSize.height)
        
        loadVisiblePages()
    }

    func loadPage(page:Int){
        if page < 0||page >= pageImages.count{
            return
        }
        
        
        if let pageView = pageViews[page]{
            
        }else{
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .ScaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
        }
    }
    
    
    func purgePage(page: Int){
        if page < 0 || page >= pageImages.count{
            return
        }
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    func loadVisiblePages(){
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth*2.0)))
        
        pageControl.currentPage = page
        
        let firstPage = page - 1
        let lastPage = page + 1
        
        for var index = 0; index < firstPage; ++index {
            purgePage(index)
        }
        
        for index in firstPage...lastPage{
            loadPage(index)
        }
        
        for var index = lastPage+1; index < pageImages.count; ++index {
            purgePage(index)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!){
        loadVisiblePages()
    }
    

}
