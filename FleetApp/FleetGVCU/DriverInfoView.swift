//
//  HomeView.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import Foundation

import SwiftUI

struct DriverInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var draft: TicketDraft

    @State private var fullName: String = ""
    @State private var driverID: String = ""
    @State private var certificationStatus: String = "Certified (Active)"
    @State private var emergencyContact: String = ""
    @State private var goToTripDetails = false
    @EnvironmentObject var navigationManager: NavigationManager

    let certificationOptions = [
        "Certified (Active)",
        "Pending",
        "Expired"
    ]
    
    var body: some View {
        
        ZStack {
            
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
                
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("WORK TICKET")
                                .font(.caption)
                                .foregroundColor(.blue)
                            
                            Text("Driver Info")
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("STEP")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("2 / 5")
                                .font(.headline.bold())
                                .foregroundColor(.white)
                        }
                    }
                    
                    ProgressView(value: 0.4)
                        .tint(.blue)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("SECTION B")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        Text("Please verify and complete the driver's identification details for this journey.")
                            .foregroundColor(.white.opacity(0.8))
                        
//                        inputField("Full Name", "e.g. Johnathan Doe", $fullName)
//                        inputField("Driver ID Number", "GOV - 8829 - X", $driverID)
                        TextField("Driver Name", text: $draft.driverName).foregroundColor(.white)
                        TextField("Driver ID/Staff Number", text: $draft.driverId).foregroundColor(.white)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Driver Certification Status")
                                .foregroundColor(.white)
                            
                            Picker("", selection: $certificationStatus) {
                                ForEach(certificationOptions, id: \.self) {
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
                        
                        if certificationStatus == "Certified (Active)" {
                            HStack {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                
                                Text("IDENTITY VERIFIED & CERTIFIED")
                                    .foregroundColor(.green)
                                    .font(.caption.bold())
                            }
                        }
                        
                        inputField("Driver Contact Number", "+1 (555) 000-0000", $emergencyContact).foregroundColor(.white)
                        
//                        ZStack(alignment: .bottomLeading) {
//                            RoundedRectangle(cornerRadius: 16)
//                                .fill(Color.white.opacity(0.05))
//                                .frame(height: 120)
//                            
//                            HStack {
//                                Image(systemName: "location.fill")
//                                    .foregroundColor(.blue)
//                                Text("Primary District Coverage")
//                                    .foregroundColor(.white)
//                            }
//                            .padding()
//                        }
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
                        navigationManager.path.append("trip")
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
        
//        .navigationDestination(isPresented: $goToTripDetails) {
//            TripDetailsView()
//        }
    }
    
    
    
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
