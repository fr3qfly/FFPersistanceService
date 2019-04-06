//
//  User.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 6/4/19.
//

import Foundation
import FFPersistanceService

struct User: Codable, UserDefaultsPersistable, PersistanceKeyRepresentable {
    static let persistanceKey: String = "kUser"
    
    let name: String
    let email: String
}

extension User: CustomStringConvertible {
    var description: String {
        return """
        User:\n
        Name: \(name)
        Email: \(email)
        """
    }
}
