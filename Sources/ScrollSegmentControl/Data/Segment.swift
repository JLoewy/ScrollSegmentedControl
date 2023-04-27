//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation

public struct Segment {
    
    public let title: String
    public var object: Any?
    
    public init(title: String, object: Any? = nil) {
        self.title = title
        self.object = object
    }
}
