//
//  JtoOError.swift
//  JtoO
//
//  Created by Alper KARATAŞ on 25/01/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation

public enum JtoOError : Error, CustomStringConvertible , Equatable {
    case childLabelError()
    case dictMustHave(key:String)
    case dictValNotConform(key:String)
    case objectPropertyNotConform(key:String)
    case typeMismatch(key:String)
    case dictKeyCantBeNull(key:String)
    
    public var description: String {
        return "JtoOError: \(caseDescription)"
    }
    
    var caseDescription: String {
        switch self {
        case .childLabelError():return "Error while reading mirror child label."
        case .dictMustHave(key: let key): return "Dictionary must have key: \(key)"
        case .dictValNotConform(key: let key):return "Dictionary key: \(key) value type does not conform JtoOProperty"
        case .objectPropertyNotConform(key: let key):return "Object property: \(key) does not conform JtoOProperty"
        case .typeMismatch(key: let key):return "Object property: \(key) type not mismatch dictionary key: \(key)"
        case .dictKeyCantBeNull(key: let key):return "Dictionay key: \(key) cant be null because Object property: \(key) is not optional "
        }
    }
    
    public static func ==(lhs: JtoOError, rhs: JtoOError) -> Bool {
        switch (lhs, rhs) {
        case (.childLabelError, .childLabelError):
            return true
        case (let .typeMismatch(str1), let .typeMismatch(str2)):
            return true
        default:
            return false
        }
    }
    
}
