//
//  Extensions.swift
//  CARDinal
//
//  Created by Alexander McGreevy on 9/30/25.
//

import Foundation

extension String {
    var isEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension Optional where Wrapped == String {
    var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let string):
            return string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    
    var orEmpty: String {
        return self ?? ""
    }
}
