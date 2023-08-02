//
//  FileManager-DocumentsDirectory.swift
//  SharkAlert
//
//  Created by Renato Martins on 02/08/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
