//
//  SupportStepViewController.swift
//  4Football
//
//  Created by Gabriel Muelas on 16/06/22.
//

import UIKit

class SupportStepViewController: StepViewController {
    
    private var countries = [Country]() {
        didSet {
            // TODO: too slow
            countryPicker.isUserInteractionEnabled = true
        }
    }

    private var selectedCountry: Country? = nil {
        didSet {
            if let selectedCountry {
                countryPicker.title = selectedCountry.name
                countryPicker.iconUrl = selectedCountry.imageUrl
            }
        }
    }
    
    override var headingText: String { "Support" }
    override var paragraphText: String { "teste teste teste teste teste teste teste teste teste" }

    private lazy var countryPicker: Picker = .init(
        title: "Select your national team",
        iconPlaceholder: .init(named: "brasao")!,
        target: self,
        action: #selector(showCountryVC)
    )

    override var child: UIView {
        let stack = UIStackView(arrangedSubviews: [countryPicker, UIView()])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.setContentHuggingPriority(.defaultLow, for: .vertical)
        return stack
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.isUserInteractionEnabled = false
        
        let request = GetCountries()
        FootballAPIClient.shared.send(request) { response in
            switch response {
            case .failure(let error):
                print(error.message)
            case .success(let countriesArray):
                self.countries = countriesArray
            }
        }
    }

    @objc func showCountryVC() {
        let selectionViewController = SelectionViewController(data: countries)
        selectionViewController.onDismiss = {
            self.selectedCountry = selectionViewController.selection
        }
        selectionViewController.sheetPresentationController?.prefersGrabberVisible = true
        present(selectionViewController, animated: true)
    }

    @objc func showTeamVC() {
        
    }
}
