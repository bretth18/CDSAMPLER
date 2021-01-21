//
//  Helper.swift
//  CDSAMPLER
//
//  Created by Brett Henderson on 1/16/21.
//

import Foundation


// Helper function reads out file at given path, returns the date it was created. On fail the current date is returned.
func getCreationDate(for file: URL) -> Date {
    
    if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
       
       let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
        return creationDate
        
    } else {
        return Date()
    }
}
