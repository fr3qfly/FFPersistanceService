//
//  StringExtension.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 6/4/19.
//

import Foundation

extension String {
    func notEmpty() -> String? {
        return self != "" ? self : nil
    }
}
