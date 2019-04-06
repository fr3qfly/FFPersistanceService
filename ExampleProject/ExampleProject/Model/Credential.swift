//
//  Credential.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 6/4/19.
//

import Foundation
import FFPersistanceService

struct Credential: Codable, SecurePersistable, PersistanceKeyRepresentable {
    static let persistanceKey: String = "kCredential"
    
    let username: String
    let password: String
}

extension Credential: CustomStringConvertible {
    var description: String {
        return """
        Credential:\n
          username: \(username)
          password: \(password)
        """
    }
}
