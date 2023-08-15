//
//  CustomCenter.swift
//  SharkAlert
//
//  Created by Renato Martins on 15/08/2023.
//

import Foundation
import SwiftUI

struct CustomCenter: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        context[HorizontalAlignment.center]
    }
}

extension HorizontalAlignment {
    static let customCenter: HorizontalAlignment = .init(CustomCenter.self)
}
