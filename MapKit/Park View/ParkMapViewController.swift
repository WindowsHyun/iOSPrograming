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
            case .MapPins:
                addAttractionPins()
            case .MapRoute:
                addRoute()
            case .MapBoundary:
                addBoundary()
            case .MapCharacterLocation:
                addCharacterLocation()
            case .MapFood:
                addMapPins()
            default:
                break;
            }
        }
    }
    
    func addRoute() {
        let thePath = NSBundle.mainBundle().pathForResource("EntranceToGoliathRoute", ofType: "plist")
        let pointsArray = NSArray(contentsOfFile: thePath!)
        
        let pointsCount = pointsArray!.count
        
        var pointsToUse: [CLLocationCoordinate2D] = []
        
        for i in 0...pointsCount-1 {
            let p = CGPointFromString(pointsArray![i] as! String)
            pointsToUse += [CLLocationCoordinate2DMake(CLLocationDegrees(p.x), CLLocationDegrees(p.y))]
        }
        
        let myPolyline = MKPolyline(coordinates: &pointsToUse, count: pointsCount)
        
        mapView.addOverlay(myPolyline)
    }
    
    func addBoundary() {
        let polygon = MKPolygon(coordinates: &park.boundary, count: park.boundaryPointsCount)
        mapView.addOverlay(polygon)
    }
    
    func addMapPins() {
        let filePath = NSBundle.mainBundle().pathForResource("FoodList", ofType: "plist")
        let attractions = NSArray(contentsOfFile: filePath!)
        for attraction in attractions! {
            let point = CGPointFromString(attraction["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = attraction["name"] as! String
            let typeRawValue = Int(attraction["type"] as! String)!
            let type = AttractionType(rawValue: typeRawValue)!
            let subtitle = attraction["subtitle"] as! String
            let annotation = AttractionAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            mapView.addAnnotation(annotation)
        }
    }

    
    func addAttractionPins() {
        let filePath = NSBundle.mainBundle().pathForResource("MagicMountainAttractions", ofType: "plist")
        let attractions = NSArray(contentsOfFile: filePath!)
        for attraction in attractions! {
            let point = CGPointFromString(attraction["location"] as! String)
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
            let title = attraction["name"] as! String
            let typeRawValue = Int(attraction["type"] as! String)!
            let type = AttractionType(rawValue: typeRawValue)!
            let subtitle = attraction["subtitle"] as! String
            let annotation = AttractionAnnotation(coordinate: coordinate, title: title, subtitle: subtitle, type: type)
            mapView.addAnnotation(annotation)
        }
    }
    
    func addCharacterLocation() {
        let batmanFilePath = NSBundle.mainBundle().pathForResource("BatmanLocations", ofType: "plist")
        let batmanLocations = NSArray(contentsOfFile: batmanFilePath!)
        let batmanPoint = CGPointFromString(batmanLocations![Int(rand()%4)] as! String)
        let batmanCenterCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(batmanPoint.x), CLLocationDegrees(batmanPoint.y))
        let batmanRadius = CLLocationDistance(max(5, Int(rand()%40)))
        let batman = Character(centerCoordinate:batmanCenterCoordinate, radius:batmanRadius)
        batman.color = UIColor.blueColor()
        
        let tazFilePath = NSBundle.mainBundle().pathForResource("TazLocations", ofType: "plist")
        let tazLocations = NSArray(contentsOfFile: tazFilePath!)
        let tazPoint = CGPointFromString(tazLocations![Int(rand()%4)] as! String)
        let tazCenterCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(tazPoint.x), CLLocationDegrees(tazPoint.y))
        let tazRadius = CLLocationDistance(max(5, Int(rand()%40)))
        let taz = Character(centerCoordinate:tazCenterCoordinate, radius:tazRadius)
        taz.color = UIColor.orangeColor()
        
        let tweetyFilePath = NSBundle.mainBundle().pathForResource("TweetyBirdLocations", ofType: "plist")
        let tweetyLocations = NSArray(contentsOfFile: tweetyFilePath!)
        let tweetyPoint = CGPointFromString(tweetyLocations![Int(rand()%4)] as! String)
        let tweetyCenterCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(tweetyPoint.x), CLLocationDegrees(tweetyPoint.y))
        let tweetyRadius = CLLocationDistance(max(5, Int(rand()%40)))
        let tweety = Character(centerCoordinate:tweetyCenterCoordinate, radius:tweetyRadius)
        tweety.color = UIColor.yellowColor()
        
        mapView.addOverlay(batman)
        mapView.addOverlay(taz)
        mapView.addOverlay(tweety)
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
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!{
        let annotationView = AttractionAnnotationView(annotation: annotation, reuseIdentifier: "Attraction")
        annotationView.canShowCallout = true
        return annotationView
    }
    
    
    
    //MKMapViewDelegate 메소드
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is ParkMapOverlay {
            // overlay_park 이미지 파일 읽어서 ParkMapOverlayView 로 만듦
            let magicMountainImage = UIImage(named: "overlay_park")
            let overlayView = ParkMapOverlayView(overlay: overlay, overlayImage: magicMountainImage!)
            
            return overlayView
        }
        else if overlay is MKPolyline{
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blueColor()
            
            return lineView
        }
        else if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.magentaColor()
            
            return polygonView
        }
        else if overlay is Character {
            let circleView = MKCircleRenderer(overlay: overlay)
            circleView.strokeColor = (overlay as! Character).color
            
            return circleView
        }
        
        return nil
    }
}

