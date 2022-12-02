//
//  ContentView.swift
//  HW4_SwiftUI_miniApp
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI


struct PersonList: View {
    
    var body: some View {
        NavigationView {
            List (persons) {
                person in
                
                NavigationLink {
                    InfoDetail(person: person)
                } label: {
                    PersonRow(person: person)
                }
                
            }
            .navigationTitle("Любимые персонажи:")
            
        }
    }
    
}



struct PersonList_Previews: PreviewProvider {
    static var previews: some View {
        PersonList()
    }
}
