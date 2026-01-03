//
//  Place.swift
//  LocationAndPlaceLookup
//
//  Created by Matthew Peterson on 12/31/25.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID().uuidString
    private var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    // initialize a place from just coordinates
    init(location: CLLocation) async {
        
        do {
            let request = MKReverseGeocodingRequest(location: location)
            guard let mapItem = try await request?.mapItems.first else {
                self.init(mapItem:  MKMapItem())
                return
            }
            self.init(mapItem: mapItem)
        } catch {
            print("😡🌎 GEOCODING ERROR: \(error.localizedDescription)")
            self.init(mapItem: MKMapItem())
            
        }
        
    }
    
    var name: String {
        self.mapItem.name ?? ""
    }
    
    var latitude: CLLocationDegrees {
        self.mapItem.location.coordinate.latitude // Tutorial uses .placemark instead of .location, but .placemark was deprecated in Xcode 26
    }
    
    var longitude: Double { // CLLocationDegrees is an alias for double, as seen here
        self.mapItem.location.coordinate.longitude
    }
    
    var address: String {
        print("mapItem.address?.shortAddress: \(mapItem.address?.shortAddress ?? "")")
        return mapItem.address?.shortAddress ?? ""
    }
}

