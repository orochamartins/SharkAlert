//
//  EventTypeMarker.swift
//  SharkAlert
//
//  Created by Renato Martins on 05/08/2023.
//

import SwiftUI

struct SeenMarker: View {
    var body: some View {
        ZStack {
            Image(systemName: "triangle.fill")
                .font(.largeTitle)
                .foregroundStyle(.linearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom))
                .shadow(radius: 2.0)
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct AttackMarker: View {
    var body: some View {
        ZStack {
            Image(systemName: "hexagon.fill")
                .font(.largeTitle)
                .foregroundStyle(.linearGradient(colors: [.red, .pink], startPoint: .top, endPoint: .bottom))
                .shadow(radius: 2.0)
            Image(systemName: "hexagon")
                .font(.largeTitle)
                .foregroundColor(.white)
            Image(systemName: "drop.fill")
                .font(.subheadline)
                .foregroundColor(.white)
        }
    }
}
