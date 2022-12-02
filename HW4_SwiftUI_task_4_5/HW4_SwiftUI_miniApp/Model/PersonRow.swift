//
//  personRow.swift
//  HW4_SwiftUI_miniApp
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI

struct PersonRow: View {
    var person: Person
    
    var body: some View {
        HStack{
            Image(person.imageName)
                .resizable()
                .frame(width: 50, height: 50, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2.0))
            VStack (alignment: .leading) {
                Text(person.name).font(.headline)
                Text(person.characterFrom).font(.subheadline)
            }
            
        }
        .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
        
    }
    
}



struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonRow(person: persons[0])
            PersonRow(person: persons[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
