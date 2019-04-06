//
//  ErrorExtension.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 6/4/19.
//

import Foundation

extension Error {
    var nsError: NSError {
        var localizedDescription = self.localizedDescription
        if let myError = self as? MyError {
            localizedDescription = myError.message
        }
        let error = self as NSError
        return NSError(domain: error.domain, code: error.code, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}
