//
//  ViewController.swift
//  MapKit_CoreLocation
//
//  Created by Alex M on 22.11.2022.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {


    private let activityIndicator = UIActivityIndicatorView()

    private lazy var moveMapToLocationButton = CustomButton(systemName: "paperplane", titleColor: .white) {
        [weak self] in
        self?.setMapToLocation()
    }


    private lazy var removeAllAnnotationsButton = CustomButton(systemName: "mappin.slash", titleColor: .white) {
        [weak self] in
        self?.removeAllannotations()
    }

    private lazy var mapTypeButton = CustomButton(systemName: "map", titleColor: .white) {
        [weak self] in

        let alertController = UIAlertController(title: nil, message: "Тип карты", preferredStyle: .actionSheet)

        ["Схема", "Спутник", "Гибрид"].forEach { value in

            let action = UIAlertAction(title: value, style: .default) { action in

                switch value {
                case "Схема" : self?.mapView.mapType = .standard
                case "Спутник" : self?.mapView.mapType = .satellite
                case "Гибрид" : self?.mapView.mapType = .hybrid
                default: self?.mapView.mapType = .standard
                }
            }

            alertController.addAction(action)
        }

        self?.present(alertController, animated: true)
    }


    private lazy var showTrafficButton = CustomButton(systemName: "car.2", titleColor: .white) {
        [weak self] in
        self?.mapView.showsTraffic.toggle()
    }


    private lazy var addRouteButton = CustomButton(systemName: "arrow.triangle.swap", titleColor: .white) {
        [weak self] in
        TextPicker.default.showInfo(showIn: self!, title: "Маршрут", message: "для построения маршрута нажмите и удеривайте точку на карте")
    }

    private lazy var annotationsArray: [MKPointAnnotation] = []

    private lazy var mapView = MKMapView()


    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAuthorization()
        setupMapView()
        configureMapView()
        setGesture()
    }



    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        [mapView,
         moveMapToLocationButton,
         removeAllAnnotationsButton,
         mapTypeButton,
         showTrafficButton,
         addRouteButton,
         activityIndicator].forEach { view.addSubview($0) }


        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            moveMapToLocationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            moveMapToLocationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moveMapToLocationButton.heightAnchor.constraint(equalToConstant: 50),
            moveMapToLocationButton.widthAnchor.constraint(equalToConstant: 50),

            removeAllAnnotationsButton.bottomAnchor.constraint(equalTo: moveMapToLocationButton.topAnchor, constant: -10),
            removeAllAnnotationsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            removeAllAnnotationsButton.heightAnchor.constraint(equalToConstant: 50),
            removeAllAnnotationsButton.widthAnchor.constraint(equalToConstant: 50),


            mapTypeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mapTypeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mapTypeButton.heightAnchor.constraint(equalToConstant: 50),
            mapTypeButton.widthAnchor.constraint(equalToConstant: 50),

            showTrafficButton.topAnchor.constraint(equalTo: mapTypeButton.bottomAnchor, constant: 10),
            showTrafficButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            showTrafficButton.heightAnchor.constraint(equalToConstant: 50),
            showTrafficButton.widthAnchor.constraint(equalToConstant: 50),


            addRouteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addRouteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addRouteButton.heightAnchor.constraint(equalToConstant: 50),
            addRouteButton.widthAnchor.constraint(equalToConstant: 50),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),

        ])
    }


    private func configureMapView() {
        mapView.mapType = .standard
        setMapToLocation()
    }


    private func removeAllannotations() {
        annotationsArray.forEach { annotation in
            mapView.removeAnnotation(annotation)
        }
    }


    private func setMapToLocation() {

        let manager = CLLocationManager()
        if let coordinates = manager.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 3000, longitudinalMeters: 3000)
            mapView.setRegion(region, animated: true)
        } else {
            TextPicker.default.showInfo(showIn: self, title: "Ошибка", message: "не удалось определить текущее положение")
        }
    }

    private func addRoute(coordinate: CLLocationCoordinate2D) {

        mapView.removeOverlays(mapView.overlays)

        let directionRequest = MKDirections.Request()

        let manager = CLLocationManager()
        if let coordinates = manager.location?.coordinate {
            let sourcePlaceMark = MKPlacemark(coordinate: coordinates)


            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)

            let destinationPlaceMark = MKPlacemark(coordinate: coordinate)

            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)


            directionRequest.transportType = .automobile
            let directions = MKDirections(request: directionRequest)

            self.activityIndicator.startAnimating()

            directions.calculate { [weak self] response, error in

                guard let self = self else {
                    return
                }

                guard let response = response else {
                    if let error = error {
                        print(error)
                    }
                    return
                }

                guard let route = response.routes.first else {
                    return
                }

                self.mapView.delegate = self
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)

                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                self.activityIndicator.stopAnimating()
            }

        } else {
            TextPicker.default.showInfo(showIn: self, title: "Ошибка", message: "не удалось определить текущее положение")
        }
    }



    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = .systemGreen
        return renderer
    }



    private func addPin(coordinate: CLLocationCoordinate2D) {

        TextPicker.default.getText(showIn: self) { [weak self] text in
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = text
            self?.mapView.addAnnotation(annotation)
            self?.annotationsArray.append(annotation)
        }

    }


    private func requestLocationAuthorization() {

        let manager = CLLocationManager()
        manager.delegate = self

        let currentStatus = manager.authorizationStatus

        switch currentStatus {

        case .notDetermined:
            manager.requestWhenInUseAuthorization()


        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsTraffic = true
            mapView.showsScale = true
            mapView.showsUserLocation = true
            manager.desiredAccuracy = 100
            manager.startUpdatingLocation()
            setMapToLocation()

        case .restricted, .denied:
            DispatchQueue.main.async {
                TextPicker.default.showInfo(showIn: self, title: "Приложение не имеет доступа к геолокации", message: "Для включения перейдите в настройки телефона")
            }


        @unknown default:
            fatalError("Не обрабатываемый статус")
        }

    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthorization()
    }



    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }



    private func setGesture(){
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureReconizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        mapView.addGestureRecognizer(lpgr)
    }

    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
            let touchLocation = gestureReconizer.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)

            TextPicker.default.checkAction(showIn: self, title1: "Добавить метку", title2: "Маршрут сюда", completion1: {
                self.addPin(coordinate: locationCoordinate)

            }, completion2: {
                self.addRoute(coordinate: locationCoordinate)
            })


            return
        }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
    }


}

