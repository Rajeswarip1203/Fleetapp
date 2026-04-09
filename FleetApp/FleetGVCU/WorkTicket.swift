import Foundation

struct WorkTicket: Identifiable {
    let id = UUID()
    
    var driverName: String
    var driverId: String
    
    var vehicleNumber: String
    var vehicleType: String
    
    var tripStart: String
    var tripEnd: String
    
    var fuelUsed: String
    var maintenanceNotes: String
    
    var authorizedBy: String
}
