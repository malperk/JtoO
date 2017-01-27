//
//  Extensions.swift
//  JtoO
//
//  Created by Alper KARATAŞ on 25/01/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

import Foundation


extension UInt32:JtoOProperty{}
extension Int:JtoOProperty{}
extension String:JtoOProperty{}
extension Optional:JtoOOptionalProperty{
    public func unwrapped() -> Any{
        switch self {
        case .some(let unwrapped):
            return unwrapped
        default:
            return self as Any
        }
    }
}
