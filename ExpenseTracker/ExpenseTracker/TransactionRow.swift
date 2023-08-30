//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay {
                    FontIcon.text(.awesome5Solid(code: transaction.icon), fontsize: 24, color: .icon)
                }
            
            VStack(alignment: .leading, spacing: 6) {
                // MARK: transaction merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: transaction category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                // MARK: transaction date
                Text(Date(), format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)

            }
            Spacer()
            
            // MARK: Transaction amount
            Text(transaction.singedAmount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? .text : .primary)
        }
        .padding([.top, .bottom], 6)
    }
}

struct TransactionRow_Previews: PreviewProvider {    
    static var previews: some View {
        TransactionRow(transaction: transiontionPreviewData)
        TransactionRow(transaction: transiontionPreviewData)
            .preferredColorScheme(.dark)
    }
}
