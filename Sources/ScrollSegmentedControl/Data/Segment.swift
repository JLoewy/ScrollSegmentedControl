//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation

// MARK: - Segment Protocol

public protocol Segment {
    var title: String { get }
    var object: Any? { get }
    
    var id: String { get }
}

extension Segment {
    
    /// Checks if the two objects segment conformers are equatable.
    /// - Important: Does not take the *object* variable into account when determining equitability
    /// - Parameter other: **Segment**
    /// - Returns: **Bool**
    public func isEqual(to other: Segment) -> Bool {
        type(of: self) == type(of: other) && self.id == other.id
    }
}

// MARK: - SegmentItem

/// Generic convenience struct that conforms to Segment
public struct SegmentItem: Segment {
    
    public let title: String
    public var object: Any?
    
    public var id: String { self.title }
    
    public init(title: String, object: Any? = nil) {
        self.title  = title
        self.object = object
    }
}
