//
//  LogInView.swift
//  SwiftUI-demo
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI


struct LogInView: View {

    @State private var login: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 100.0, height: 100.0)
                .offset(y: -150)
                .padding(.bottom, -150)

            VStack {
                TextField("Email or phone", text: $login)
                    .padding(.leading, 10)
                    .padding(.top, 10)
                
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)

                TextField("Password", text: $password)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
            }
            .background(Color(uiColor: .systemGray6))
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10.0)
                .strokeBorder(.gray, style: StrokeStyle(lineWidth: 1.0)))
            .padding(20)
            Button("Log in") {
                print("Login - \(login)")
                print("Password - \(password)")
            }
            .frame(width: UIScreen.main.bounds.size.width - 40, height: 50.0)

            .background(Color("mainBlue"))
            .cornerRadius(10)
            .foregroundColor(.white)
        }
    }

}




struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

