//
//  AddEventView.swift
//  SharkAlert
//
//  Created by Renato Martins on 03/08/2023.
//

import SwiftUI

struct AddEventView: View {
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("Add Shark Event")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Select event type")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                HStack(spacing: 16) {
                    Group {
                        VStack(spacing: 16) {
                            Image(systemName: "square")
                                .font(.largeTitle)
                            Text("Shark seen")
                                .font(.title2)
                        }
                        .contentShape(Rectangle())
                        .foregroundColor(vm.eventType == "seen" ? .blue : .black)
                        .onTapGesture {
                            vm.eventType = "seen"
                        }
                        
                        
                        VStack(spacing: 16) {
                            Image(systemName: "triangle")
                                .font(.largeTitle)
                            Text("Shark attack")
                                .font(.title2)
                        }
                        .contentShape(Rectangle())
                        .foregroundColor(vm.eventType == "attack" ? .blue : .black)
                        .onTapGesture {
                            vm.eventType = "attack"
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.secondary)
                    }
                    .padding(.vertical)
                }
            }
        }
        .padding()
    }
}

struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventView()
            .environmentObject(ViewModel())
    }
}
