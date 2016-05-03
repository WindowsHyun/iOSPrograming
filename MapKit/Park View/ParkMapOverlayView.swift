//
//  ParkMapOverlayView.swift
//  Park View
//
//  Created by HyunWindows on 2016. 5. 3..
//  Copyright © 2016년 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

class ParkMapOverlayView: MKOverlayRenderer {
    var overlayImage: UIImage
    
    init(overlay:MKOverlay, overlayImage:UIImage) {
        self.overlayImage = overlayImage
        super.init(overlay: overlay)
    }
    
    override func drawMapRect(mapRect: MKMapRect, zoomScale: MKZoomScale, inContext context: CGContext!) {
        let imageReference = overlayImage.CGImage
        
        let theMapRect = overlay.boundingMapRect
        let theRect = rectForMapRect(theMapRect)
        
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextTranslateCTM(context, 0.0, -theRect.size.height)
        CGContextDrawImage(context, theRect, imageReference)
    }
}