//
//  TargetMarker.swift
//  SharkAlert
//
//  Created by Renato Martins on 02/08/2023.
//

import SwiftUI

struct TargetMarker: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.15)
                .stroke(.primary, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: 0, to: 0.15)
                .stroke(.primary, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(90))
            
            Circle()
                .trim(from: 0, to: 0.15)
                .stroke(.primary, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-180))
            
            Circle()
                .trim(from: 0, to: 0.15)
                .stroke(.primary, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            
            Circle()
                .fill(.primary.opacity(0.5))
                .frame(maxWidth: 10)
                
        }
        .frame(maxWidth: 60)
        .rotationEffect(.degrees(16.5))
        .opacity(0.5)
    }
}

struct TargetMarker_Previews: PreviewProvider {
    static var previews: some View {
        TargetMarker()
    }
}
