import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var store: TicketStore
    @EnvironmentObject var navigationManager: NavigationManager
    
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
            
            VStack {
                
                // MARK: Empty State
                if store.tickets.isEmpty {
                    
                    Spacer()
                    
                    Text("No Tickets Available")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView {
                        
                        VStack(spacing: 16) {
                            
                            ForEach(store.tickets) { ticket in
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    
                                    Text("Driver: \(ticket.driverName)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text("Driver ID: \(ticket.driverId)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Vehicle: \(ticket.vehicleNumber)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Vehicle Type: \(ticket.vehicleType)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Trip: \(ticket.tripStart) → \(ticket.tripEnd)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Fuel Used: \(ticket.fuelUsed)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Maintenance: \(ticket.maintenanceNotes)")
                                        .foregroundColor(.white.opacity(0.8))
                                    
                                    Text("Authorized By: \(ticket.authorizedBy)")
                                        .foregroundColor(.blue)
                                        .bold()
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading) // 🔥 important
                                .background(
                                    RoundedRectangle(cornerRadius: 18)
                                        .fill(Color.white.opacity(0.08))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color.white.opacity(0.12))
                                )
                            }
                        }}

                }
                
                // MARK: Create Button
                Button("Create Ticket") {
                    navigationManager.path.append("vehicle")
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dashboard")
                        .font(.title.bold())
                        .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            
        }
    }
}
