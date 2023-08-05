//
//  EventTypeMarker.swift
//  SharkAlert
//
//  Created by Renato Martins on 05/08/2023.
//

import SwiftUI

struct SeenMarker: View {
    var body: some View {
        Image(systemName: "triangle.fill")
            .font(.largeTitle)
            .foregroundColor(.yellow)
    }
}

struct AttackMarker: View {
    var body: some View {
        Image(systemName: "hexagon.fill")
            .font(.largeTitle)
            .foregroundColor(.red)
    }
}
