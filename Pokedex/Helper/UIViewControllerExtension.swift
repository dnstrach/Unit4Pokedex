//
//  UIViewControllerExtension.swift
//  Pokedex
//
//  Created by Dominique Strachan on 1/10/23.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}

