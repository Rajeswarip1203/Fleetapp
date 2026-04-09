//
//  FuelMaintenanceView.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import SwiftUI

struct FuelMaintenanceView: View {
    @State private var goToAuthorization = false
    @EnvironmentObject var navigationManager: NavigationManager

    @Environment(\.dismiss) var dismiss
    
    @State private var fuelIssued = ""
    @State private var receiptNumber = ""
    @State private var endOdometer = ""
    @State private var hasMaintenanceIssue = false
    
    @State private var roadworthy = true
    @State private var insuranceValid = true
    @State private var inspectionValid = false
    @EnvironmentObject var draft: TicketDraft

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
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .onTapGesture { dismiss() }
                        
                        Spacer()
                        
                        Text("WORK TICKET")
                            .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Image(systemName: "ellipsis")
                            .foregroundColor(.blue)
                    }
                    
                    Text("Fuel & Maintenance")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    ProgressView(value: 0.8)
                        .tint(.blue)
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(spacing: 20) {
                        
                        // FUEL CARD
                        formCard {
                            //TextField("Fuel Used", text: $draft.fuelUsed)
                            //TextField("Maintenance Notes", text: $draft.maintenanceNotes)
                            
                            input("Fuel Issued (Litres)", $fuelIssued)
                            input("Fuel Card/Receipt Number", $receiptNumber)
                            input("Odometer Reading (End)", $endOdometer)
                            
                            Toggle("Maintenance Issues Reported", isOn: $hasMaintenanceIssue)
                                .foregroundColor(.white)
                        }
                        
                        // COMPLIANCE
                        formCard {
                            complianceRow("Vehicle Roadworthiness Confirmed", $roadworthy)
                            complianceRow("Insurance Validity", $insuranceValid)
                            complianceRow("Inspection Certificate Validity", $inspectionValid)
                        }
                        
                        warningBox
                    }
                    .padding()
                }
                
                Button {
                    navigationManager.path.append("auth")
                } label: {
                    HStack {
                        Spacer()
                        Text("Submit Section")
                            .bold()
                        Image(systemName: "arrow.right")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                    )
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        
//        .navigationDestination(isPresented: $goToAuthorization) {
//            AuthorizationView()
//        }
    }
}
    
    
    func input(_ title: String, _ binding: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.gray)
            TextField("", text: binding)
                .padding()
                .background(Color.white.opacity(0.08))
                .cornerRadius(12)
                .foregroundColor(.white)
        }
    }
    
    
    func complianceRow(_ title: String, _ binding: Binding<Bool>) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            Spacer()
            Toggle("", isOn: binding)
                .labelsHidden()
        }
        .padding(.vertical, 5)
    }
    
    
    var warningBox: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
            
            Text("Failure to report non-compliance or maintenance issues may result in disciplinary action.")
                .foregroundColor(.yellow)
                .font(.footnote)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.yellow.opacity(0.1))
        )
    }
    
    
    func formCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 20, content: content)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.08))
            )
    }
