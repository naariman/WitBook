//
//  BaseImage.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

enum BaseImage: String {
    
    case ic_back
    case ic_bell
    case ic_close
    case ic_dashboard
    case ic_profile
    case ic_dashboard_selected
    case ic_profile_selected
    case ic_add_photo_placeholder
    case ic_timer

    var uiImage: UIImage? {
        return UIImage(named: self.rawValue, in: .main, compatibleWith: nil)
    }
}
