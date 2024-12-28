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
    
    var uiImage: UIImage? {
        return UIImage(named: self.rawValue, in: .main, compatibleWith: nil)
    }
}
