//
//  JtoOProperty.swift
//  JtoO
//
//  Created by Alper KARATAŞ on 25/01/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

public protocol JtoOProperty {
}

extension JtoOProperty {
    func codeIntoP(_ pointer: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer{
        let re = pointer.assumingMemoryBound(to: Self.self)
        re.pointee = self
        return UnsafeMutableRawPointer(re.advanced(by:1))
    }
    func codeOptionalInto(_ pointer: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer {
        let re = pointer.assumingMemoryBound(to: Optional<Self>.self)
        re.pointee = self
        return UnsafeMutableRawPointer(re.advanced(by:1))
    }
    func codeNilInto(_ pointer: UnsafeMutableRawPointer) -> UnsafeMutableRawPointer {
        let re = pointer.assumingMemoryBound(to:Optional<Self>.self)
        re.pointee = .none
        return UnsafeMutableRawPointer(re.advanced(by:1))
    }
    
    func cast(_ from: Any) -> Self? {
        return from as? Self
    }
}

public protocol JtoOOptionalProperty {
    func unwrapped() -> Any
}


