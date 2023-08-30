//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
