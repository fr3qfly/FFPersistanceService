//
//  View.swift
//  ExampleProject
//
//  Created by Balazs Szamody on 5/4/19.
//

import UIKit

protocol ViewDelegate: AnyObject {
    func view(_ view: View, didTapButton button: UIButton)
}

class View: UIView, NibLoadable {
    
    static let nib = UINib(nibName: "View", bundle: Bundle.main)
    
    var viewType: ViewType = .userDeafults

    @IBOutlet var labels: [UILabel]!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var objectLabel: UILabel!
    
    override func awakeFromNib() {
        objectLabel.text = nil
    }
    
    weak var delegate: ViewDelegate?
    
    @IBAction func buttonDidTap(_ sender: UIButton) {
        delegate?.view(self, didTapButton: sender)
    }
    
    func clear() {
        textFields.forEach({ $0.text = nil})
        objectLabel.text = nil
    }
    
}
