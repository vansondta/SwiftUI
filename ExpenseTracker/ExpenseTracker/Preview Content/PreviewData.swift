//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import Foundation
import SwiftUI

var transiontionPreviewData = Transaction(id: 1, date: "1/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)
var transiontionListPreviewData = [Transaction](repeating: transiontionPreviewData, count: 10)
