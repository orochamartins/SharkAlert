//
//  EventDetailsView.swift
//  SharkAlert
//
//  Created by Renato Martins on 07/08/2023.
//

import SwiftUI

struct EventDetailsView: View {
    
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
                
            } label: {
                HStack {
                    Image(systemName: "flag")
                    Text("Report event")
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .padding([.vertical], 24)
                .background(.red.opacity(0.2))
                .cornerRadius(12)
            }
        }
        .padding()
        .padding([.top])
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Location.example)
    }
}
