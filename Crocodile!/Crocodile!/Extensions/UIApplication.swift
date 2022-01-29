//
//  UIApplication.swift
//  Crocodile!
//
//  Created by Майлс on 28.01.2022.
//

import UIKit

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
