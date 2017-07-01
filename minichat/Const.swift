//
//  Const.swift
//  minichat
//
//  Created by Thannathrn Yuwasin on 6/24/2560 BE.
//  Copyright © 2560 Thannathrn Yuwasin. All rights reserved.
//

import Foundation
import UIKit
class Const {
    
    static func CurrentDateTimeToStr() -> String {
        let currentDate = Date()
        let dateFormenter = DateFormatter()
        dateFormenter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormenter.string(from: currentDate)
        
        
    }
    
}
