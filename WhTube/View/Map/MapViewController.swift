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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//
//        let location = CLLocationCoordinate2D(latitude: 37.5412092163375, longitude: 126.973835448986)
//
//        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        map.setRegion(region, animated: true)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = location
//        annotation.title = "이치젠덴푸라메시"
//        annotation.subtitle = "#이치젠 #이치젠덴푸라메시 #튀김정식"
//        map.addAnnotation(annotation)
//
        let stadiums = [Stadium(name: "남한강민물매운탕", lattitude: 37.545626109663, longtitude:127.066210285087),
        Stadium(name: "이치젠덴푸라메시", lattitude: 37.5412092163375, longtitude:126.973835448986 ),
        Stadium(name: "꿉당성수점", lattitude: 37.5432276384361, longtitude: 127.057641548378),
        Stadium(name: "텍사스데브라질", lattitude: 37.5044921229104, longtitude: 127.007845270854),
        Stadium(name: "보화장", lattitude: 37.4453664562966, longtitude:126.658851267432)]
        
        fetchStadiumsOnMap(stadiums)
    }
    func fetchStadiumsOnMap(_ stadiums: [Stadium]) {
      for stadium in stadiums {
        let annotations = MKPointAnnotation()
        annotations.title = stadium.name
        annotations.coordinate = CLLocationCoordinate2D(latitude:
          stadium.lattitude, longitude: stadium.longtitude)
        map.addAnnotation(annotations)
      }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
