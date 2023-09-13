//
//  campoNumerico.swift
//  ejTienda
//
//  Created by AlumnoPro on 01/10/2021.
//


import Foundation
import UIKit

class campoNumerico: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range( of: ".")
        let replacementTextHasDecimalSeparator = string.range( of: ".")
        
        let charactersNotAllowed = NSCharacterSet.letters
        let replacementTextHasLetter = string.rangeOfCharacter(from: charactersNotAllowed)
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil{
            if replacementTextHasLetter != nil{
                return false
            }
            return false
        } else {
            if replacementTextHasLetter != nil{
                return false
            }
            return true
        }
    }
    
    
}
