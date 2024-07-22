//
//  EditingView.swift
//  HotProspects
//
//  Created by Aimee Temple on 2024-07-22.
//
import SwiftData
import SwiftUI

struct EditingView: View {
    @Bindable var prospect: Prospect
    
    
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            
            TextField("Name", text: $prospect.name)
            TextField("Email Address", text: $prospect.emailAddress)
            Toggle("Contacted", isOn: $prospect.isContacted)
        }
    
    
    

        

    }
    func newForm() {
        prospect.name = ""
        prospect.emailAddress = ""
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let example = Prospect(name: "example", emailAddress: "example@user.com", isContacted: false)
        return EditingView(prospect: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
        
    }
}











































