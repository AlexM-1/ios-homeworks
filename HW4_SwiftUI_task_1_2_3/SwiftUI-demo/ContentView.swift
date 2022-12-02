//
//  ContentView.swift
//  SwiftUI-demo
//
//  Created by Alex M on 01.12.2022.
//

import SwiftUI


// MARK: Задача 1: примеры из лекции


//struct ContentView: View {
//
//    @State private var isPushEnabled = false
//
//    var body: some View {
//
//        NavigationView {
//            Form {
//                Section {
//                    Toggle(isOn: $isPushEnabled) {
//                        Text("Включить нотификации")
//                    }
//                }
//            }
//            .navigationTitle("Настройки")
//        }
//    }
//}



//struct ContentView: View {
//
//    @State private var speed = 30.0
//    @State private var isEditing = false
//
//    var body: some View {
//        VStack {
//            Slider(value: $speed, in: 0...100) {
//                editing in
//                isEditing = editing
//            }
//            Text("\(speed)")
//                .foregroundColor(isEditing ? .red : .green)
//
//        }
//        .padding(16)
//       // .modifier(Title())
//
//    }
//}

//
//
//struct MyPicker: View {
//    @State private var favoriteColor = 0
//
//    var body: some View {
//        Picker(selection: $favoriteColor, label: Text("Color")) {
//            Text("Red").tag(0)
//            Text("Green").tag(1)
//        }
//        .onChange(of: favoriteColor) { tag in print("Color tag: \(tag)") }
//    }
//}



//struct Universe: Identifiable {
//    var id: String { name }
//    let name: String
//}



//struct ContentView: View {
//
//    @State var selectedUniverse: Universe?
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Какая киновселенная вам нравится больше?")
//                .multilineTextAlignment(.center)
//            Button("Marvel") {
//                selectedUniverse = .init(name: "Marvel")
//
//            }
//            Button("DC") {
//                selectedUniverse = .init(name: "DC")
//
//            }
//            Text(selectedUniverse?.name ?? "Ничего не нравится")
//
//        }
//        .padding(32)
//        .alert(item: $selectedUniverse) { universe in
//            Alert(title: Text(universe.name), message: Text("Спасибо за выбор!"), dismissButton: .default(Text("OK")))
//        }
//    }
//}

// создать свой модификатор
//struct Title: ViewModifier {
//   func body(content: Content) -> some View {
//       content
//           .font(.largeTitle)
//           .foregroundColor(.white)
//           .padding()
//           .background(Color.blue)
//           .clipShape(RoundedRectangle(cornerRadius: 10))
//} }


// использование модификатора
//Text("Hello World")
//    .modifier(Title())


// MARK: Задача 2: модификаторы для текста

struct CircleImage: View {
    var body: some View {
        Image("foto1")
            .resizable()
            .frame(width: 200.0, height: 200.0)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.gray, lineWidth: 4)
            }
            .shadow(radius: 7)

    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)

                .frame(height: 100)
            Text("Hello, world!")
                .modifier(Title())
            Text("Hello, world!")
                .modifier(Regular())
        }
        .padding()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.green)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

}

struct Regular: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.regular)
            .padding()
            .foregroundColor(.accentColor)
        
        
    }
}



