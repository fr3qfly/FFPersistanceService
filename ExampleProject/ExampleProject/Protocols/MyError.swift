//
//  MyError.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 6/4/19.
//

import Foundation

protocol MyError: Error {
    var message: String { get }
}
