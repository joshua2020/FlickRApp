//
//  CommonConstants.swift
//  FlickRApp
//
//  Created by Joshua on 20/09/2022.
//

import Foundation
import UIKit

struct CommonConstants {
    
    struct Api {
        static let baseApiUrl = "https://api.flickr.com/services"
        static let apiKey = "c0c6eb134120c85a9924f90528669a7a"
        static let groupSearchMethod = "flickr.groups.search"
        static let photoSearchMethod = "flickr.photos.search"
        static let getPhotoInfoMethod = "flickr.photos.getInfo"
    }

    struct Indentifiers {
        static let cellID: String = "pictureCell"
        static let pictureSegue: String = "showPictureDetails"
        static let GlobalColour = UIColor(hexString: "#B90202")
    }
}
