//
//  ParkMapViewController.swift
//  Park View
//
//  Created by Niv Yahel on 2014-11-09.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

import UIKit
import MapKit

enum MapType: Int {
  case Standard = 0
  case Hybrid
  case Satellite
}

class ParkMapViewController: UIViewController {
  
    @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
  
  var selectedOptions = [MapOptionsType]()
    
    var park = Park(filename: "MagicMountain")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // 파크의 midCoordinate로 부터 위아래 위도차 span을 만들고
        // 이를 이용해서 식스플래그 region을 만듦
        let latDelta = park.overlayTopLeftCoordinate.latitude -
            park.overlayBottomRightCoordinate.latitude
        
        // think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let region = MKCoordinateRegionMake(park.midCoordinate, span)
        
        mapView.region = region
    }
  
    func addOverlay() {
        let overlay = ParkMapOverlay(park: park)
        mapView.addOverlay(overlay)
    }
    
    func loadSelectedOptions() {
        // MapOverlay를 그리기 전에 이전 annotation과 overlay삭제
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        // 옵션에 따라서 overlay그리기
        for option in selectedOptions {
            switch (option) {
            case .MapOverlay:
                addOverlay()
            default:
                break;
            }
        }
    }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let optionsViewController = segue.destinationViewController as! MapOptionsViewController
    optionsViewController.selectedOptions = selectedOptions
  }
  
  @IBAction func closeOptions(exitSegue: UIStoryboardSegue) {
    let optionsViewController = exitSegue.sourceViewController as! MapOptionsViewController
    selectedOptions = optionsViewController.selectedOptions
    self.loadSelectedOptions()
  }
  
  @IBAction func mapTypeChanged(sender: AnyObject) {
    // To be implemented
    let mapType = MapType(rawValue: mapTypeSegmentedControl.selectedSegmentIndex)
    switch (mapType!) {
    case .Standard:
        mapView.mapType = MKMapType.Standard
    case .Hybrid:
        mapView.mapType = MKMapType.Hybrid
    case .Satellite:
        mapView.mapType = MKMapType.Satellite
    }
    
  }
}

extension ParkMapViewController: MKMapViewDelegate{
    //MKMapViewDelegate 메소드
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is ParkMapOverlay {
            // overlay_park 이미지 파일 읽어서 ParkMapOverlayView 로 만듦
            let magicMountainImage = UIImage(named: "overlay_park")
            let overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            
            return overlayView
        } 
        
        return nil
    }
}

