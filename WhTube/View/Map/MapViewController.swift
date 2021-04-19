//
//  MapViewController.swift
//  WhTube
//
//  Created by Terry on 2020/12/02.
//

import UIKit
import MapKit


struct Stadium {
    var name: String
    var lattitude: CLLocationDegrees
    var longtitude: CLLocationDegrees
}

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    var mapList = [markerLists]()
    var viewModel : MapViewModel!
    
    let distanceSapn:CLLocationDistance = 50000
    
    var name : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MapViewModel(changehandler: { [self] mapPing in
            let Array = mapPing.first!.Lists
            var stadium : [Stadium] = []
            for item in Array {
                stadium.append(Stadium(name:item.name, lattitude: item.latitude, longtitude: item.longitude))
            }
            self.fetchStadiumsOnMap(stadium)
        })
        print("name \(self.name)")
        viewModel.MapfetchData()
        
    }
    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
        for stadium in stadiums {
            let annotations = MKPointAnnotation()
            annotations.title = stadium.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
              stadium.lattitude, longitude: stadium.longtitude)
            let mapCoordinates = MKCoordinateRegion(center: annotations.coordinate, latitudinalMeters: distanceSapn, longitudinalMeters: distanceSapn)
            map.setRegion(mapCoordinates, animated: true)
            map.addAnnotation(annotations)
            map.scalesLargeContentImage = true
          }
    }
}
