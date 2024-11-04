//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/3/24.
//

import Foundation
import UIKit

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}
