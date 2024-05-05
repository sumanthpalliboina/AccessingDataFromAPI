//
//  PostsData.swift
//  AccessingDataFromAPI
//
//  Created by Palliboina on 05/05/24.
//

import Foundation
import UIKit

enum Sections{
    case main
}

struct Post:Codable,Identifiable{
    var id:Int
    var userId:Int
    var title:String
    var body:String
}

class PostsData{
    var datasource:UITableViewDiffableDataSource<Sections,Post.ID>!
    var listPosts:[Post] = []
}

var postsData = PostsData()
