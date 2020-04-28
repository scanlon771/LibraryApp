//
//  Book.swift
//  Library
//
//  Created by Kenneth Scanlon on 4/17/20.
//  Copyright © 2020 Kenneth Scanlon. All rights reserved.
//

import UIKit

struct Book {
    let title: String
    //let author: String
    let pageCount: Int
    let currentPage: Int
    let cover: String
    //let online: String
}

extension Book {
    init(dictionary: [String: AnyObject]) {
        title = dictionary["Title"] as! String
        //author = dictionary["Author"] as! String
        pageCount = dictionary["PageCount"] as! Int
        currentPage = dictionary["CurrentPage"] as! Int
        cover = dictionary["Cover"] as! String
        //online = dictionary["Online"] as! String
    }
}
