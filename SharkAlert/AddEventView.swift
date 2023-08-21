//
//  AddEventView.swift
//  SharkAlert
//
//  Created by Renato Martins on 03/08/2023.
//

import SwiftUI

struct AddEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Add Shark Event")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Add a type and time of the occurrence")
                    .foregroundColor(.secondary)
                
            }
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 16) {
                    VStack(spacing: 16) {
                        SeenMarker()
                        Text("Shark seen")
                            .font(.title2)
                    }
                    .contentShape(Rectangle())
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(vm.eventType == "seen" ? .yellow : .secondary)
                    }
                    .background(vm.eventType == "seen" ? .yellow.opacity(0.2) : .white).cornerRadius(8)
                    .onTapGesture {
                        vm.eventType = "seen"
                    }
                    
                    VStack(spacing: 16) {
                        AttackMarker()
                        Text("Shark attack")
                            .font(.title2)
                    }
                    .contentShape(Rectangle())
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(vm.eventType == "attack" ? .red : .secondary)
                    }
                    .background(vm.eventType == "attack" ? .red.opacity(0.2) : .white).cornerRadius(8)
                    .onTapGesture {
                        vm.eventType = "attack"
                    }
                }
                
                DatePicker("Select date", selection: $vm.currentDate, in: ...Date())
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.secondary.opacity(0.6))
                    }
                
                Button {
                    vm.addEvent()
                    dismiss()
                    print(vm.locations)
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add event")
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding([.vertical], 24)
                    .background(.black)
                    .cornerRadius(12)
                    .opacity(vm.eventType == "" ? 0.6 : 1.0)
                }
                .disabled(vm.eventType == "")
            }
        }
        .padding()
        .padding([.top])
    }
    
    struct AddEventView_Previews: PreviewProvider {
        static var previews: some View {
            AddEventView(vm: ViewModel())
        }
    }
}
