//
//  Book.swift
//  AccessingDataFromAPI
//
//  Created by Palliboina on 05/05/24.
//

import Foundation
import UIKit

///if we want convert json to swift strcuture, structure must conform to Codable protocol
struct Book:Codable {
    var title:String
    var author:String
}
