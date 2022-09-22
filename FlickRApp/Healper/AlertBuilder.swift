//
//  AlertBuilder.swift
//  FlickRApp
//
//  Created by Joshua on 20/09/2022.
//

import Foundation
import UIKit

class AlertBuilder {
    func showError(message: String) {
        let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene

        let rootViewController = scene?
            .windows.first(where: { $0.isKeyWindow })?
            .rootViewController

        if let rootController = rootViewController {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            rootController.present(alertController, animated: true, completion: nil)
        }
    }
}

