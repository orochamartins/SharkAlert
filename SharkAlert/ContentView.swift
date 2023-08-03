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
                    vm.isShowingSheet.toggle()
                } label: {
                    HStack {
                        Image(systemName: "triangle")
                        Text("Add Shark Event")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding([.vertical], 24)
                    .background(.black)
                    .cornerRadius(12)
                    .padding()
                }
            }
        }
        .environmentObject(vm)
        .sheet(isPresented: $vm.isShowingSheet) {
            AddEventView()
                .presentationDetents([.fraction(0.45)])
                .presentationDragIndicator(.visible)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
