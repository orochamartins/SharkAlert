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
        NavigationView {
            ZStack{
                Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        if location.eventType == "seen" {
                            SeenMarker()
                                .onTapGesture {
                                    vm.selectedEvent = location
                                }
                        } else {
                            AttackMarker()
                                .onTapGesture {
                                    vm.selectedEvent = location
                                }
                        }
                    }
                }
                .ignoresSafeArea()
                .onChange(of: vm.selectedEvent) { newValue in
                    if let result = newValue?.coordinate {
                        withAnimation {
                            vm.mapRegion.center = CLLocationCoordinate2D(latitude: result.latitude - 0.85, longitude: result.longitude)
                            vm.mapRegion.span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                        }
                    }
                }
                
                TargetMarker()
                
                VStack {
                    Spacer()
                    Button {
                        vm.isShowingSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                                .font(.largeTitle)
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80)
                        .background(.black)
                        .clipShape(Circle())
                    }
                }
            }
            .environmentObject(vm)
            .sheet(isPresented: $vm.isShowingSheet) {
                AddEventView()
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                        }
                    }
                    .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                        vm.addEventHeight = newHeight
                    }
                    .environmentObject(vm)
                    .presentationDetents([.height(vm.addEventHeight)])
                    .presentationDragIndicator(.visible)
            }
            .sheet(item: $vm.selectedEvent, onDismiss: vm.reset) { event in
                EventDetailsView(event: event)
                    .overlay {
                        GeometryReader { geometry in
                            Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                        }
                    }
                    .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                        vm.eventDetailsHeight = newHeight
                    }
                    .presentationDetents([.height(vm.eventDetailsHeight)])
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: "triangle")
                }
            }
        }
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
