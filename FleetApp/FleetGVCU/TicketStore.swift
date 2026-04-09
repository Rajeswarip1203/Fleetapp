//
//  TicketStore.swift
//  FleetGVCU
//
//  Created by Rajeswari on 17/02/26.
//

import Foundation

class TicketStore: ObservableObject {
    @Published var tickets: [WorkTicket] = []
    
    func add(ticket: WorkTicket) {
        tickets.append(ticket)
    }
}
