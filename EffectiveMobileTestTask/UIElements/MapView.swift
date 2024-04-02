//
//  mapView.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import UIKit
import MapKit

class MapView: UIView {
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var addressString: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        let bundle = loadViewFromXib()
        
        addSubview(bundle)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("MapView", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
}

extension MapView {
    func setupFields(addressStringArray: Address, companyName: String) {
        companyLabel.text = companyName
        let addressString = addressStringArray.town + addressStringArray.street + addressStringArray.house
        addressLabel.text = addressString
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemark = placemarks?.first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.location!.coordinate
                annotation.title = companyName
                self.mapView.addAnnotation(annotation)
                
                let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
}
