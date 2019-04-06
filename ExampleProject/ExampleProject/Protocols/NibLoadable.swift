//
//  NibLoadable.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 5/4/19.
//

import UIKit

protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
    init()
}

fileprivate enum NibLoadableError: MyError {
    case loadingFailed
    
    var message: String {
        switch self {
        case .loadingFailed:
            return "Couldn't instantiate View from Nib"
        }
    }
}

extension NibLoadable where Self: View {
    
    static func loadFromNib() throws -> Self {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? Self else {
            throw NibLoadableError.loadingFailed
        }
        return view
    }
}
