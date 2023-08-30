//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var demoData: [Double] = [8, 2 , 4, 6, 12, 9 , 2]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Chart view
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty {
                        let totalExpeneses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpeneses.formatted(.currency(code: "USD")), type: .title, format: "$%.02f")
                                
                                LineChart()
                            }
                            .background(Color.systemBackground)
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: .systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    }
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.backgound)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transiontionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)

        }
        .environmentObject(transactionListVM)
    }
}
