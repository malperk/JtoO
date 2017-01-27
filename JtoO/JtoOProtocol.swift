//
//  JtoOProtocol.swift
//  JtoO
//
//  Created by Alper KARATAŞ on 25/01/17.
//  Copyright © 2017 Alper KARATAŞ. All rights reserved.
//

public protocol JtoOProtocol {
    static func construct <T>(dict:[String:Any?])throws -> T
}


    public func construct <T>(dict:[String:Any?])throws -> T {
        
        let typedPointer =  UnsafeMutablePointer<T>.allocate(capacity: 1)
        var rawPointer = UnsafeMutableRawPointer(typedPointer)
        
        let mirror = Mirror(reflecting:typedPointer.pointee)
        
        for child in mirror.children {
            guard let key = child.label else {
                throw JtoOError.childLabelError()
            }
            
            //Check dictionary has key
            guard let dictVal = dict[key] else {
                if let val = child.value as? JtoOOptionalProperty{
                    if let unwrappedVal = val.unwrapped() as? JtoOProperty{
                        rawPointer = unwrappedVal.codeNilInto(rawPointer)
                    }
                    else{
                        throw JtoOError.objectPropertyNotConform(key: key)
                    }
                }
                else{
                    throw JtoOError.dictMustHave(key: key)
                }
                continue
            }
            
            //Check dictionary key is nil
            guard let wrappedDictVal = dictVal else{
                if let val = child.value as? JtoOOptionalProperty{
                    if let unwrappedVal = val.unwrapped() as? JtoOProperty{
                        rawPointer = unwrappedVal.codeNilInto(rawPointer)
                    }
                    else{
                        throw JtoOError.objectPropertyNotConform(key: key)
                    }
                }
                else{
                    throw JtoOError.dictKeyCantBeNull(key: key)
                }
                continue
            }
            
            
            if let dictProperty = wrappedDictVal as? JtoOProperty {
                if child.value is JtoOOptionalProperty{
                    rawPointer = dictProperty.codeOptionalInto(rawPointer)
                }
                else{
                    rawPointer = dictProperty.codeIntoP(rawPointer)
                }
            }
        }
        return typedPointer.pointee as! T
    }

