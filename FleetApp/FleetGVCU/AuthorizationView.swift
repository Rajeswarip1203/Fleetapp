//
//  AuthorizationView.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import SwiftUI

struct AuthorizationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: TicketStore
    @State private var officerName = ""
    @State private var designation = ""
    @State private var agree = false
    //@EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var draft: TicketDraft
    @EnvironmentObject var navigationManager: NavigationManager

    let designationOptions = [
        "Supervisor",
        "Manager",
        "Head of Department"
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
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                        .foregroundColor(.blue)
                    }
                    
                    Text("Authorization")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Text("Section E: Final Submission")
                        .foregroundColor(.gray)
                    
                    ProgressView(value: 1.0)
                        .tint(.blue)
                }
                .padding(.horizontal)
                
                ScrollView {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Info Card
                        HStack(alignment: .top) {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.blue)
                            
                            Text("Please ensure all trip and fuel records are accurate before signing. This authorization serves as an official government record.")
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.blue.opacity(0.15))
                        )
                        
                        // Officer Name
                        input("Authorizing Officer Name", $officerName)
                        
                        // Designation
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Designation")
                                .foregroundColor(.gray)
                            
                            Picker("Select Rank/Position", selection: $designation) {
                                Text("Select Rank/Position").tag("")
                                ForEach(designationOptions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.08))
                            )
                        }
                        
                        // Signature
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Signature")
                                .foregroundColor(.gray)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.08))
                                    .frame(height: 180)
                                
                                Text("Sign within the frame")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Agreement
                        Toggle(isOn: $agree) {
                            Text("I hereby certify that the particulars shown in this work ticket are correct and the vehicle was used solely for official government business.")
                                .foregroundColor(.white)
                                .font(.footnote)
                        }
                    }
                    .padding()
                    
                }
                
                // Submit Button
                Button {
                    let finalTicket = draft.createFinalTicket()
                       store.add(ticket: finalTicket)
                       
                       draft.reset()
                       
                       navigationManager.path = NavigationPath()
                } label: {
                    HStack {
                        Spacer()
                        Text("SUBMIT TICKET")
                            .bold()
                        Image(systemName: "arrow.right")
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(agree ? Color.blue : Color.gray)
                    )
                }
                .disabled(!agree)
                .padding()
                
                Text("SECURED GOVERNMENT PORTAL")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .navigationBarBackButtonHidden(true)
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
}
