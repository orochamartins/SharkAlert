//
//  ContentView.swift
//  SharkAlert
//
//  Created by Renato Martins on 31/07/2023.
//

import SwiftUI
import MapKit
import Combine

struct ContentView: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(Circle())
                }
            }
            .ignoresSafeArea()
            
            TargetMarker()
            
            VStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "triangle")
                    Text("Add Shark Event")
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.vertical], 24)
                .background(.primary)
                .cornerRadius(12)
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
