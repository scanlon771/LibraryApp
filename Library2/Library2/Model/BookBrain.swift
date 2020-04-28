//
//  BookBrain.swift
//  Library
//
//  Created by Kenneth Scanlon on 4/21/20.
//  Copyright © 2020 Kenneth Scanlon. All rights reserved.
//

import Foundation

struct BookBrain {
    
    func getProgress(currentPage: Int, pageCount: Int) -> Float {
        let progress = Float(currentPage) / Float(pageCount)
        return progress
    }
    

}
