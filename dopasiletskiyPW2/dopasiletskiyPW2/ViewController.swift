//
//  ViewController.swift
//  dopasiletskiyPW2
//
//  Created by Даниил Пасилецкий on 21.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationTextView()
        setupSettingsButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    

    
    
    private func setupSettingsButton(){
        let settingsButton = UIButton(type: .system)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
                                 for: .touchUpInside)
        view.addSubview(settingsButton)
        settingsButton.setTitle("settings", for: .normal)
        settingsButton.setImage(
            UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 15
        ).isActive = true
        settingsButton.trailingAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.trailingAnchor,
            constant: -15
        ).isActive = true
        settingsButton.heightAnchor.constraint(
            equalToConstant: 30
        ).isActive = true
        settingsButton.widthAnchor.constraint(
            equalTo:settingsButton.heightAnchor
        ).isActive = true
    }
    
    
    private let locationTextView = UITextView()
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        locationTextView.backgroundColor = .white
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor,
            constant: 60
        ).isActive = true
        locationTextView.centerXAnchor.constraint(
            equalTo: view.centerXAnchor
        ).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        locationTextView.leadingAnchor.constraint(
            equalTo: view.leadingAnchor,
            constant: 15
        ).isActive = true
        locationTextView.isUserInteractionEnabled = false
    }
    
    
    
    private var buttonCount = 0
    private var sliders = [UISlider(), UISlider(), UISlider()]
    @objc private func settingsButtonPressed() {
    let next = SettingViewController()
        next.locationTextView = locationTextView
        next.view1 = self.view
        next.sliders = sliders
    switch buttonCount {
    case 0, 1:
    UIView.animate(withDuration: 0.1, animations: {
//        TODO#1
    })
    case 2:
    navigationController?.pushViewController(
    next,
    animated: true
    )
    case 3:
        next.setupCloseButton()
       present(next, animated: true,
       completion: nil)
    default:
         buttonCount = -1
        }
        buttonCount += 1
    }
}









