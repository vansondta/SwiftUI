//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by SonNV3 on 29/08/2023.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPerfixSum =  [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private var cancellabels = Set<AnyCancellable>()
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { complete in
                switch complete {
                case .failure(let error):
                    print("Error fetching transaction", error.localizedDescription)
                case .finished:
                    print("finished fetching transaction")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellabels)
    }
    
    func groudTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        let gounpedTransactions = TransactionGroup(grouping: transactions, by: { $0.month })
        return gounpedTransactions
    }
    
    func accumulateTransactions() -> TransactionPerfixSum {
        print("accumulateTransactions")
        guard !transactions.isEmpty else { return [] }
        let today = "02/17/2022".datePased()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print("dateInterval: \(dateInterval)")
        var sum: Double = .zero
        var cumulativesum = TransactionPerfixSum()
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.singedAmount}
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativesum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
        }
        return cumulativesum
    }
}
