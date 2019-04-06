//
//  ViewModel.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 5/4/19.
//

import Foundation
import FFPersistanceService

protocol ErrorHandler {
    var error: Error? { get set }
}

protocol ErrorDelegate: AnyObject {
    func errorHandler(_ errorHandler: ErrorHandler, didReceiveError error: Error)
}

enum ViewType {
    case userDeafults
    case keychain
}

class ViewModel: ErrorHandler {
    
    enum ViewModelError: MyError {
        case emptyField
        case notStored(Persistable.Type)
        case deleteFailed
        
        var message: String {
            switch self {
            case .emptyField:
                return "Please fill both fields"
            case .notStored(let type):
                return "Please save \(type) first."
            case .deleteFailed:
                return "Couldn't delete object"
            }
        }
    }
    
    var error: Error? {
        didSet {
            guard let error = error else {
                return
            }
            errorDelegate?.errorHandler(self, didReceiveError: error)
        }
    }
    
    weak var errorDelegate: ErrorDelegate?
    
    func configure(_ view: View) {
        let firstLabel: String?
        let secondLabel: String?
        switch view.viewType {
        case .userDeafults:
            firstLabel = "Name:"
            secondLabel = "Email:"
            view.textFields[1].keyboardType = .emailAddress
        case .keychain:
            firstLabel = "username:"
            secondLabel = "password:"
            view.textFields[1].isSecureTextEntry = true
        }
        view.labels[0].text = firstLabel
        view.labels[1].text = secondLabel
    }
    
    func save(_ viewType: ViewType, value: (String?, String?)) {
        guard let first = value.0?.notEmpty(), let second = value.1?.notEmpty() else {
            error = ViewModelError.emptyField.nsError
            return
        }
        let model: (PredefinedPersistable & PersistanceKeyRepresentable)
        switch viewType {
        case .userDeafults:
            model = User(name: first, email: second)
        case .keychain:
            model = Credential(username: first, password: second)
        }
        do {
            try model.save()
        } catch {
            self.error = error
        }
    }
    
    func load(_ viewtype: ViewType) -> String? {
        switch viewtype {
        case .userDeafults:
            guard let user = try? User.get() else {
                return "Please save user first"
            }
            return user.description
        case .keychain:
            do {
                return try Credential.get().description
            } catch {
                print(error)
                self.error = ViewModelError.notStored(Credential.self).nsError
                return nil
            }
        }
    }
    
    func delete(_ viewType: ViewType) -> Bool {
        do {
            switch viewType {
            case .userDeafults:
                try User.delete()
            case .keychain:
                try Credential.delete()
            }
            return true
        } catch {
            print(error)
            self.error = ViewModelError.deleteFailed
            return false
        }
    }
}
