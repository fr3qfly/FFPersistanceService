//
//  ViewController.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 5/4/19.
//

import UIKit

class ViewController: UIViewController {
    enum ViewError: MyError {
        case buttonNotHandled
    }
    
    let viewModel = ViewModel()

    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.errorDelegate = self
        do {
            try setupStackView()
        } catch {
            viewModel.error = error
        }
        
    }
    
    func setupStackView() throws {
        let userDefaultView = try View.loadFromNib()
        userDefaultView.delegate = self
        viewModel.configure(userDefaultView)
        stackView.addArrangedSubview(userDefaultView)
        
        let keychainView = try View.loadFromNib()
        keychainView.viewType = .keychain
        keychainView.delegate = self
        viewModel.configure(keychainView)
        stackView.addArrangedSubview(keychainView)
    }


}

extension ViewController: ErrorDelegate {
    func errorHandler(_ errorHandler: ErrorHandler, didReceiveError error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        present(alert, animated: true) {
            sleep(2)
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension ViewController: ViewDelegate {
    func view(_ view: View, didTapButton button: UIButton) {
        switch button {
        case view.buttons[0]:
            viewModel.save(view.viewType, value: (view.textFields[0].text, view.textFields[1].text))
        case view.buttons[1]:
            view.objectLabel.text = viewModel.load(view.viewType)
        case view.buttons[2]:
            if viewModel.delete(view.viewType) {
                view.clear()
            }
        default:
            viewModel.error = ViewError.buttonNotHandled
        }
        UIView.animate(withDuration: 0.2) {
            view.layoutIfNeeded()
        }
    }
}

extension ViewController.ViewError {
    var message: String {
        switch self {
        case .buttonNotHandled:
            return "The action from this button isn't handled"
        }
    }
}
