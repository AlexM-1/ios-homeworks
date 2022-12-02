//
//  infoDetail.swift
//  HW4_SwiftUI_miniApp
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI

struct InfoDetail: View {
    
    var person: Person
    
    var body: some View {
        ScrollView {
            
            Image(person.imageName)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
            
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.title)
                
                Text(person.characterFrom)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Text(person.description)
            }
        }
        .padding()
    }
    
}


struct InfoDetail_Previews: PreviewProvider {
    static var previews: some View {
        InfoDetail(person: persons[1])
    }
    
}


