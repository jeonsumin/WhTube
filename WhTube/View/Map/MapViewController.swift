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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapViewModel.shared.mapListResponse { response in
            switch response{
            case .success(let result):
                print("result :: \(result)")
                DispatchQueue.main.async {
                    self.mapList.append(contentsOf: result)
                }
            case .failure(let error):
            print("error \(error.localizedDescription)")
            }
        }
        fetchStadiumsOnMap(mapList)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDIdAppear")
        print("mapList \(mapList)")
    }
    func fetchStadiumsOnMap(_ stadiums: [markerLists]) {
        for stadium in stadiums {
            let annotations = MKPointAnnotation()
            annotations.title = stadium.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                                                                CLLocationDegrees(stadium.latitude), longitude: CLLocationDegrees(stadium.longitude))
            map.addAnnotation(annotations)
        }
    }
}
