//
//  Extensions.swift
//  swiftUiFirebase
//
//  Created by Ground 2 on 11/04/24.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
