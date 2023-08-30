//
//  RecentTransactionList.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel 
    
    var body: some View {
        VStack {
            HStack {
                // MARK: Header title
                Text("Recent Transactions")
                    .bold()
                
                Spacer()
                // MARK: Header link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4) {
                        Text("See all")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.text)
                }
            }
            .padding(.top)
            // MARK: Recent transaction list
            
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element) { index, transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .shadow(color: Color.primary.opacity(0.1), radius: 10, x: 5, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transiontionListPreviewData
        return transactionListVM
    }()

    static var previews: some View {
        Group {
            RecentTransactionList()
            RecentTransactionList()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
