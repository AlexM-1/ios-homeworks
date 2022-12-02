///
//  MainView.swift
//  SwiftUI-demo
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI


struct MainView: View {

    var body: some View {
        TabView {
            Text("Feed view")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Feed")
                }
            LogInView()
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }

            Text("Player view")
                .tabItem {
                    Image(systemName: "headphones")
                    Text("Player")
                }

            Text("Video view")
                .tabItem {
                    Image(systemName: "play.rectangle.fill")
                    Text("Video")
                }

            Text("Recorder view")
                .tabItem {
                    Image(systemName: "mic.fill")
                    Text("Recorder")

                }
        }

    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

