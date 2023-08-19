//
//  EventDetailsView.swift
//  SharkAlert
//
//  Created by Renato Martins on 07/08/2023.
//

import SwiftUI

struct EventDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ViewModel
    
    var event: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(spacing: 20) {
                ZStack{
                    Circle()
                        .fill(event.eventType == "seen" ? .yellow : .red)
                        .opacity(0.2)
                        .frame(width: 80, height: 80)
                    
                    if event.eventType == "seen" {
                        SeenMarker()
                    } else {
                        AttackMarker()
                    }
                }
                .padding([.leading], 8)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Shark Event Details")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("Occurrence details")
                        .foregroundColor(.secondary)
                    
                }
            }
            List {
                HStack{
                    Text("Event type")
                        .font(.headline)
                    Spacer()
                    Text(event.eventType == "seen" ? "Shark seen" : "Shark attack")
                }
                
                HStack{
                    Text("Date")
                        .font(.headline)
                    Spacer()
                    Text(event.date.formatted())
                }
                
                HStack{
                    Text("Coordinates")
                        .font(.headline)
                    Spacer()
                    Text("\(event.coordinate.latitude), \(event.coordinate.longitude)")
                }
            }
            .listStyle(.inset)
            .scrollDisabled(true)
            .frame(height: 150)
            
            Button {
                vm.isReported.toggle()
            } label: {
                HStack {
                    Image(systemName: vm.reportSent ? "checkmark" : "flag")
                    Text(vm.reportSent ? "'\(vm.reportTitle)' report sent" : "Report event")
                }
                .foregroundColor(.red.opacity(vm.reportSent ? 0.6 : 1.0))
                .frame(maxWidth: .infinity)
                .padding([.vertical], 24)
                .background(.red.opacity(vm.reportSent ? 0.1 : 0.2))
                .cornerRadius(12)
            }
            .disabled(vm.reportSent)
        }
        .padding()
        .padding([.top])
        .confirmationDialog("Report event", isPresented: $vm.isReported) {
            Button("Wrong location", role: .destructive) {
                withAnimation {
                    vm.reportSent.toggle()
                    vm.reportTitle = "Wrong location"
                }
            }
            Button("Fake event", role: .destructive) {
                withAnimation {
                    vm.reportSent.toggle()
                    vm.reportTitle = "Fake event"
                }
            }
            Button("Event repeated", role: .destructive) {
                withAnimation {
                    vm.reportSent.toggle()
                    vm.reportTitle = "Event repeated"
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Select a reason for the report")
        }
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(vm: ViewModel(), event: Location.example)
    }
}
