import UIKit

class SupportStepViewController: UIViewController, OnboardingStep {
    var type: StepType { .support }
    var headingText: String { "Support" }
    var paragraphText: String { "teste teste teste teste teste teste teste teste teste" }
    var child: UIView {
        let stack = UIStackView(arrangedSubviews: [countryPicker, teamPicker, UIView()])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
        stack.setContentHuggingPriority(.defaultLow, for: .vertical)
        return stack
    }

    private var countries = [Country]() {
        didSet {
            // TODO: too slow
            countryPicker.isUserInteractionEnabled = true
        }
    }

    private var teams = [Team]() {
        didSet {
            teamPicker.isUserInteractionEnabled = true
        }
    }

    var didUpdateSelections: ((Country?, Team?) -> Void)?

    private(set) var selectedCountry: Country? = nil {
        didSet {
            if let selectedCountry {
                selectedTeam = nil
                countryPicker.picked = selectedCountry
                getTeams(from: selectedCountry)
                didUpdateSelections?(selectedCountry, selectedTeam)
            }
        }
    }

    private(set) var selectedTeam: Team? = nil {
        didSet {
            if let selectedTeam {
                teamPicker.picked = selectedTeam
                didUpdateSelections?(selectedCountry, selectedTeam)
            }
        }
    }

    private lazy var countryPicker: Picker = .init(
        text: "Select your national team",
        iconPlaceholder: .init(named: "brasao")!,
        target: self,
        action: #selector(showCountryVC)
    )

    private lazy var teamPicker: Picker = .init(
        text: "Select your team",
        iconPlaceholder: .init(named: "brasao")!,
        target: self,
        action: #selector(showTeamVC)
    )

    override func loadView() {
        view = stepView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker.isUserInteractionEnabled = false
        teamPicker.isUserInteractionEnabled = false
        
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
            if self.selectedCountry != selectionViewController.selection {
                self.teamPicker.clear()
            }
            self.selectedCountry = selectionViewController.selection
        }
        selectionViewController.sheetPresentationController?.prefersGrabberVisible = true
        present(selectionViewController, animated: true)
    }

    @objc func showTeamVC() {
        let selectionViewController = SelectionViewController(data: teams)
        selectionViewController.onDismiss = {
            self.selectedTeam = selectionViewController.selection
        }
        selectionViewController.sheetPresentationController?.prefersGrabberVisible = true
        present(selectionViewController, animated: true)
    }

    private func getTeams(from country: Country) {
        let request = GetTeams(by: [country])
        FootballAPIClient.shared.send(request) { response in
            switch response {
            case .failure(let error):
                print(error.message)
            case .success(let teamsWrapper):
                let teams = teamsWrapper.compactMap { $0.team }
                self.teams = teams.filter { !($0.national!) }
            }
        }
    }
}
