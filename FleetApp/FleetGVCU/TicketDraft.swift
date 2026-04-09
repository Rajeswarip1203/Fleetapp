//
//  TicketDraft.swift
//  FleetGVCU
//
//  Created by Rajeswari on 17/02/26.
//

import Foundation

class TicketDraft: ObservableObject {
    
    @Published var driverName = ""
    @Published var driverId = ""
    
    @Published var vehicleNumber = ""
    @Published var vehicleType = ""
    
    @Published var tripStart = ""
    @Published var tripEnd = ""
    
    @Published var fuelUsed = ""
    @Published var maintenanceNotes = ""
    
    @Published var authorizedBy = ""
    
    func createFinalTicket() -> WorkTicket {
        WorkTicket(
            driverName: driverName,
            driverId: driverId,
            vehicleNumber: vehicleNumber,
            vehicleType: vehicleType,
            tripStart: tripStart,
            tripEnd: tripEnd,
            fuelUsed: fuelUsed,
            maintenanceNotes: maintenanceNotes,
            authorizedBy: authorizedBy
        )
    }
    
    func reset() {
        driverName = ""
        driverId = ""
        vehicleNumber = ""
        vehicleType = ""
        tripStart = ""
        tripEnd = ""
        fuelUsed = ""
        maintenanceNotes = ""
        authorizedBy = ""
    }
}
