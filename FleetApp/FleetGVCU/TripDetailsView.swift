//
//  TripDetailsView.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import SwiftUI

struct TripDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var serviceDate = Date()
    @State private var timeOut = Date()
    @State private var timeIn = Date()
    @State private var destination: String = ""
    @State private var purpose: String = "Official Field Visit"
    @State private var goToFuel = false
    @EnvironmentObject var draft: TicketDraft
    @EnvironmentObject var navigationManager: NavigationManager

    let purposeOptions = [
        "Official Duty",
        "Court Delivery",
        "Field Inspection",
        "Emergency",
        "Official Field Visit",
        "Other"
    ]
    
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
                            Text("WORK TICKET DIGITALIZATION")
                                .font(.caption)
                                .foregroundColor(.blue)
                            
                            Text("Section C: Trip Details")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("Step 3 of 5")
                            .foregroundColor(.gray)
                    }
                    
                    ProgressView(value: 0.6)
                        .tint(.blue)
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        // SERVICE DATE
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Service Date")
                                .foregroundColor(.gray)
                            
                            DatePicker(
                                "",
                                selection: $serviceDate,
                                displayedComponents: .date
                            )
                            .datePickerStyle(.compact)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.08))
                            )
                            .colorScheme(.dark)
                        }
                        
                        // TIME OUT / TIME IN
                        HStack(spacing: 15) {
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Time Out")
                                    .foregroundColor(.white)
                                
                                DatePicker(
                                    "",
                                    selection: $timeOut,
                                    displayedComponents: .hourAndMinute
                                )
                                .datePickerStyle(.compact)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.08))
                                )
                                .colorScheme(.dark)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Time In")
                                    .foregroundColor(.white)
                                
                                DatePicker(
                                    "",
                                    selection: $timeIn,
                                    displayedComponents: .hourAndMinute
                                )
                                .datePickerStyle(.compact)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.08))
                                )
                                .colorScheme(.dark)
                            }
                        }
                        
                        // ROUTE INFORMATION
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Route Information")
                                .foregroundColor(.white)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Destination")
                                    .foregroundColor(.white)
                                
                                TextField("", text: $destination)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 14)
                                            .fill(Color.white.opacity(0.08))
                                    )
                                    .foregroundColor(.white)
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Purpose of Trip")
                                    .foregroundColor(.white)
                                
                                Picker("", selection: $purpose) {
                                    ForEach(purposeOptions, id: \.self) {
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
                        }
                        
                        // PASSENGER MANIFEST
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Passenger Manifest")
                                .foregroundColor(.white)
                            
                            passengerCard(name: "Johnathan Doe", id: "44921")
                            passengerCard(name: "Sarah Jenkins", id: "33812")
                            
                            Text("Click '+' to add more passengers")
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.white.opacity(0.2))
                                )
                        }
                        
                    }
                    .padding(25)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.ultraThinMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.1))
                            )
                    )
                    .padding()
                }
                
                // Bottom Buttons
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
                        navigationManager.path.append("fuel")
                    } label: {
                        HStack {
                            Text("Continue to Fuel")
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
        
//        .navigationDestination(isPresented: $goToFuel) {
//            FuelMaintenanceView()
//        }
    }
    
    func passengerCard(name: String, id: String) -> some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(.white)
                    .bold()
                Text("Employee ID: \(id)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "minus.circle")
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.08))
        )
    }
}
