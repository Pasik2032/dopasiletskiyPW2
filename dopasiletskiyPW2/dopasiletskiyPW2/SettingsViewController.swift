//
//  SettingsViewController.swift
//  dopasiletskiyPW2
//
//  Created by Даниил Пасилецкий on 21.09.2021.
//

import UIKit
import CoreLocation


final class SettingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupLocationToggle()
        setupSliders()
        locationManager.requestWhenInUseAuthorization()
    }
    
    private let locationManager = CLLocationManager()
    private func setupLocationToggle(){
        let locationToggle = UISwitch()
        if(locationTextView.text != ""){
            locationToggle.setOn(true, animated: false)
        }
        settingsView.addSubview(locationToggle)
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 50
        ).isActive = true
        locationToggle.trailingAnchor.constraint(
            equalTo: settingsView.trailingAnchor,
            constant: -10 ).isActive = true
        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
        
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(
            equalTo: settingsView.topAnchor,
            constant: 55
        ).isActive = true
        locationLabel.leadingAnchor.constraint(
            equalTo: settingsView.leadingAnchor,
            constant: 10
        ).isActive = true
        locationLabel.trailingAnchor.constraint(
            equalTo: locationToggle.leadingAnchor,
            constant: -10
        ).isActive = true
    }
    var locationTextView = UITextView()
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy =
                    kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    private let settingsView = UIView()
    private func setupSettingsView(){
        settingsView.alpha = 1
        view.addSubview(settingsView)
        settingsView.backgroundColor = .white
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 0
        ).isActive = true
        settingsView.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: 0
        ).isActive = true
        settingsView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive
            = true
        settingsView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    
    var sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
    private func setupSliders() {
        var top = 80
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(
                equalTo: settingsView.leadingAnchor,
                constant: 10
            ).isActive = true
            view.trailingAnchor.constraint(
                equalTo: settingsView.trailingAnchor,
                constant: -10 ).isActive = true
            view.topAnchor.constraint(
                equalTo: settingsView.topAnchor,
                constant: CGFloat(top)
            ).isActive = true
            view.heightAnchor.constraint(equalToConstant: 30).isActive =
                true
            top += 40
            let label = UILabel()
            view.addSubview(label)
            label.text = colors[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 5
            ).isActive = true
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ).isActive = true
            label.widthAnchor.constraint(
                equalToConstant: 50
            ).isActive = true
            let slider = sliders[i]
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.addTarget(self, action:
                                #selector(sliderChangedValue), for: .valueChanged)
            view.addSubview(slider)
            slider.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 5).isActive = true
            slider.heightAnchor.constraint(equalToConstant: 20).isActive
                = true
            slider.leadingAnchor.constraint(equalTo:
                                                label.trailingAnchor, constant: 10).isActive = true
            slider.trailingAnchor.constraint(equalTo:
                                                view.trailingAnchor).isActive = true
        }
    }
    
    public var view1 = UIView()
    
    @objc private func sliderChangedValue() {
        let red: CGFloat = CGFloat(sliders[0].value)
        let green: CGFloat = CGFloat(sliders[1].value)
        let blue: CGFloat = CGFloat(sliders[2].value)
        view1.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public func setupCloseButton() {
    let button = UIButton(type: .close)
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.trailingAnchor.constraint(
        equalTo: view.trailingAnchor,
    constant: -10 ).isActive = true
    button.topAnchor.constraint(
    equalTo: view.safeAreaLayoutGuide.topAnchor,
    constant: 10
    ).isActive = true
    button.heightAnchor.constraint(equalToConstant: 30).isActive =
    true
     button.widthAnchor.constraint(equalTo:
     button.heightAnchor).isActive = true
     button.addTarget(self, action: #selector(closeScreen),
     for: .touchUpInside)
     }
    
    @objc
    private func closeScreen() {
    dismiss(animated: true, completion: nil)
    }
}
extension SettingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
        
    }
}
