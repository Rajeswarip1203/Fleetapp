//
//  FleetGVCUApp.swift
//  FleetGVCU
//
//  Created by Rajeswari on 13/02/26.
//

import SwiftUI

//@main
//struct FleetGVCUApp: App {
//    
//    @StateObject private var store = TicketStore()
//    @StateObject private var navigationManager = NavigationManager()
//    
//    var body: some Scene {
//        WindowGroup {
//            
//            NavigationStack(path: $navigationManager.path) {
//                DashboardView()   // or WorkTicketLoginView()
//            }
//            .navigationDestination(for: String.self) { value in
//                switch value {
//                case "tripDetails":
//                    TripDetailsView()
//                case "fuel":
//                    FuelMaintenanceView()
//                case "authorization":
//                    AuthorizationView()
//                case "vehicle":
//                    VehicleInfoView()
//                case "driver":
//                    DriverInfoView()
//                default:
//                    EmptyView()
//                }
//            }
//            .environmentObject(store)
//            .environmentObject(navigationManager)
//        }
//    }
//}
//
//
//
//class NavigationManager: ObservableObject {
//    @Published var path = NavigationPath()
//    
//    func popToRoot() {
//        path = NavigationPath()
//    }
//}
//

import SwiftUI

@main
struct FleetGVCUApp: App {
    
    @StateObject private var store = TicketStore()
    @StateObject private var draft = TicketDraft()
    @StateObject private var navigationManager = NavigationManager()
    
    @State private var isLoggedIn = false
    
    var body: some Scene {
        WindowGroup {
            
            if isLoggedIn {
                
                NavigationStack(path: $navigationManager.path) {
                    
                    DashboardView()
                    
                        .navigationDestination(for: String.self) { value in
                            switch value {
                            case "vehicle":
                                VehicleInfoView()
                            case "driver":
                                DriverInfoView()
                            case "trip":
                                TripDetailsView()
                            case "fuel":
                                FuelMaintenanceView()
                            case "auth":
                                AuthorizationView()
                            default:
                                Text("Invalid Route")
                            }
                        }
                }
                .environmentObject(store)
                .environmentObject(draft)
                .environmentObject(navigationManager)
                
            } else {
                
                WorkTicketLoginView(isLoggedIn: $isLoggedIn)
                
            }
        }
    }
}
