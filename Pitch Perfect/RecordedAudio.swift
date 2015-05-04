//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Julia Stefani on 4/28/15.
//  Copyright (c) 2015 Julia Stefani. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePath: NSURL, title: String) {
        self.filePathUrl = filePath
        self.title = title
    }
}