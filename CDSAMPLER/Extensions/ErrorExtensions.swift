//
//  ErrorExtensions.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/20/21.
//

import Foundation

extension NSError: Identifiable {
    public var id: Int { code }
}
