//
//  VehicleInfoView.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import SwiftUI

struct VehicleInfoView: View {
    
    @State private var plateNumber: String = ""
    @State private var vehicleType: String = ""
    @State private var department: String = ""
    @State private var odometerStart: String = ""
    @EnvironmentObject var draft: TicketDraft
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var navigationManager: NavigationManager

    let vehicleOptions = ["Saloon", "Pickup", "Bus", "Lorry", "Other"]
    let departments = ["Transport", "Health", "Police", "Administration", "Other"]
    
    var body: some View {
        ZStack {
            
            // Background
            LinearGradient(
                colors: [
                    Color(red: 0.03, green: 0.10, blue: 0.18),
                    Color(red: 0.07, green: 0.20, blue: 0.35)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                // MARK: Header
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Work Ticket")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            
                            Text("Vehicle Information")
                                .foregroundColor(.white.opacity(0.7))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("STEP 1 OF 5")
                                .font(.caption.bold())
                                .foregroundColor(.blue)
                            
                            HStack(spacing: 6) {
                                Capsule()
                                    .fill(Color.blue)
                                    .frame(width: 30, height: 6)
                                
                                ForEach(0..<4) { _ in
                                    Capsule()
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 30, height: 6)
                                }
                            }
                        }
                    }
                }
                .padding()
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // GK Plate
                       // inputField("GK PLATE NUMBER", "", $plateNumber)
                        TextField("GK Plate Number", text: $draft.vehicleNumber).foregroundColor(.white)
                        //TextField("Vehicle Type", text: $draft.vehicleType)
                        // Vehicle Type
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Vehicle Type/Model")
                                .foregroundColor(.white)
                            
                            Picker("Select vehicle model", selection: $vehicleType) {
                                Text("Select vehicle model").tag("").foregroundColor(.white)
                                ForEach(vehicleOptions, id: \.self) {
                                    Text($0).foregroundColor(.white)
                                }
                            }.foregroundColor(.white)
                            .pickerStyle(.menu)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.08))
                            )
                            .foregroundColor(.white)
                        }
                        
                        // Department
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Department/Agency")
                                .foregroundColor(.white)
                            
                            Picker("Assign department", selection: $department) {
                                Text("Assign department").tag("")
                                ForEach(departments, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.08))
                            )
                            .foregroundColor(.white)
                        }
                        
                        // Odometer
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Odometer Reading (Start)")
                                .foregroundColor(.white)
                            
                            HStack {
                                TextField("", text: $odometerStart)
                                    .keyboardType(.numberPad)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("KM")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.08))
                            )
                            
                            Text("Check dashboard for current reading")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                    }
                    .padding(25)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.accentColor.opacity(0.1))
                            )
                    )
                    .padding()
                }
                
                // Info Note
                HStack(alignment: .top) {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                    
                    Text("Ensure the plate number and starting odometer are accurate. This information will be locked once you proceed to the next step.")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.footnote)
                }
                .padding(.horizontal)
                
//                Button("Create Ticket") {
//                    navigationManager.path.append("driver")
//                }
                HStack(spacing: 20) {
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.3))
                        )
                    }
                    
                    Button {
                        navigationManager.path.append("driver")
                    } label: {
                        HStack {
                            Text("Continue")
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue)
                        )
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    // Reusable Input
    func inputField(_ title: String,
                    _ placeholder: String,
                    _ binding: Binding<String>) -> some View {
        
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: binding)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white.opacity(0.08))
                )
                .foregroundColor(.white)
        }
    }
}
