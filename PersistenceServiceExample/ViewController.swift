//
//  ViewController.swift
//  PersistenceServiceExample
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import UIKit
import PersistanceService

class ViewController: UIViewController {
    
    let myStruct = MyStruct()

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let example = try MyStruct.get()
            print(example)
        } catch {
            print(error)
        }
        
    }


}

struct MyStruct: Codable, CustomStringConvertible, UserDefaultsPersistable, PersistanceKeyRepresentable {
    static var persistanceKey: String = "myStruct"
    
    let name = "MyStruct"
    let values = [1,2,3,4,5]
    
    var description: String {
        return "name: \(name),\nvalues: \(values)"
    }
    
    init() {
        do {
            try self.save()
        } catch {
            print(error)
        }
    }
}
