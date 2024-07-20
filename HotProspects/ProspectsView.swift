//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Aimee Temple on 2024-07-20.
//

import CodeScanner
import SwiftData
import SwiftUI

struct ProspectsView: View {
    
    enum FilterType {
        case none, contacted, uncontacted
         
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    
    @State private var isShowingScanner = false
    
    let filter: FilterType
    
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
        
    }
    
    
    
    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)
                    
                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
                .swipeActions {
                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: "person.cop.circle.badge.xmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)
                    } else {
                        Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark") {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)
                    }
                }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    isShowingScanner = true
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Joe Smith\njoe@emailaddress.com", completion: handleScan)
            }
        }
        
        
    }
    
    init(filter: FilterType) {
        self.filter = filter
        
        if filter != .none {
            let showContactOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactOnly
            }, sort: [SortDescriptor(\Prospect.name)])
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
            
        case .failure(let error):
            print("Scanneing failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospect.self)
}





































