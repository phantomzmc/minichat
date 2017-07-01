//
//  Alert.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 5/30/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    func ShowAlert(title:String, message:String ,viewController:
        UIViewController)
    {
        let alert = UIAlertController (title: title, message: message ,preferredStyle :.alert)
        let resultAlert = UIAlertAction(title :"OK" , style : .cancel, handler : nil)
        alert.addAction(resultAlert)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}

