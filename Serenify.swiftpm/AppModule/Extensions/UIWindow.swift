//
//  File.swift
//  Serenify
//
//  Created by Elyan Gutierrez on 11/3/24.
//

import Foundation
import UIKit

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
