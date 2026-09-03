//
//  LocationService.swift
//  SibiuGo
//
//  Created by Diana Ciodolan on 03/09/2026.
//

import CoreLocation
import Observation

@Observable
final class LocationService {
    private let locationManager = CLLocationManager()

    func requestPermission() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
