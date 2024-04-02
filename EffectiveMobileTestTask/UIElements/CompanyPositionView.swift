//
//  CompanyPositionView.swift
//  EffectiveMobileTestTask
//
//  Created by Александр Федоткин on 02.04.2024.
//

import UIKit
import MapKit

class CompanyPositionView: UIView {
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var addressStringArray: Address?
    var companyName: String?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        mapView.layer.cornerRadius = 8
    }
    
    private func setupView() {
        let bundle = loadViewFromXib()
        
        addSubview(bundle)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let bundle = Bundle.main.loadNibNamed("CompanyPositionView", owner: self)?.first as? UIView else { return UIView() }
        return bundle
    }
}

extension CompanyPositionView {
    func setupFields() {
        guard let addressStringArray = addressStringArray,
              let companyName = companyName else { return }
        companyLabel.text = companyName
        let addressString = addressStringArray.town + ", " + addressStringArray.street + ", " + addressStringArray.house
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
