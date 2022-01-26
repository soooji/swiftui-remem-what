//
//  ContentView.swift
//  Shared
//
//  Created by NiC on 1/24/22.
//

import SwiftUI

final class Entry {
    let value: String

    init(value: String) {
        self.value = value
    }
}

struct Reminder{
    let id = UUID()
    var title: String
    var date: Date
}

struct ContentView: View {
    @State private var noOfCompanies = "10"
    @State private var showingAlert = false
    
    @State private var reminders: [Reminder] = []
    
    @State private var isNewVisible = false

    
    private let wrapped = NSCache<NSString, NSString>()
    
    func getKey(forKey: String) -> NSString? {
        return wrapped.object(forKey: NSString(string: forKey))
    }
    
    func setKey(forKey: String, value: NSString) {
        wrapped.setObject(value, forKey: NSString(string: forKey))
    }
    
    @State var count : Int = 10
    
    func addReminder(rem: Reminder) {
        reminders.append(rem)
        withAnimation {
            isNewVisible.toggle()
        }
    }
    
    var body: some View {
        Background {
            VStack() {
                Header()
                Spacer()
                ScrollView(.vertical) {
                    VStack {
                        if(isNewVisible) {
                            NewReminder(onSubmit: addReminder, onCancel: {
                                    withAnimation {isNewVisible.toggle()}
                                }
                            )
                                .padding([.top,.leading,.trailing])
                        }
                        
                        VStack {
                            ForEach(reminders, id: \.id) {item in
                                CardItem(title: item.title ,date: item.date)
                           }
                        }
                        .padding([.leading,.trailing,.bottom,.top])
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .background(Color.init(hex: "#6b6b6b"))
                .cornerRadius(15)
                .padding(EdgeInsets.init(top: 0, leading: 15, bottom: 10, trailing: 15))

                if(!isNewVisible) {
                    Button(action: {
                        withAnimation {
                            isNewVisible.toggle()
                        }
                    }){
                        Text("New Reminder")
                            .font(.system(size: 17, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                            .background(Color(hex: "1b1b1b"))
                            .cornerRadius(10)
                    }
                    .padding([.leading,.trailing])
                }
                    
                // Buttons
//                HStack(){
//                    Button(action: {
//                        setKey(forKey: "noco", value: NSString(string: noOfCompanies))
//                    }){
//                        Text("Set")
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color(hex: "1b1b1b"))
//                    }
//
//                    Button(action: {
//                        let val = getKey(forKey: "noco")
//                        if((val) != nil) {
//                            showingAlert.toggle()
//                            noOfCompanies = val! as String
//                        }
//                    }){
//                        Text("Get")
//                            .frame(maxWidth: .infinity)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color(hex: "1b1b1b"))
//                    }
//                    .alert("Important message" + noOfCompanies, isPresented: $showingAlert) {
//                        Button("OK", role: .cancel) { }
//                    }
//                }
//                .cornerRadius(10)
//                .padding([.leading,.trailing])
            }
            .frame(minWidth: 0 ,maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.init(hex: "#3b3b3b"))
        }
        .onTapGesture {
            self.endEditing()
        }
    }
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Background<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

//    UIScreen.main.bounds.width
//    UIScreen.main.bounds.height
    var body: some View {
        Color.white
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(content)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//                        VStack() {
//                            Text("Compnaies:")
//                                .foregroundColor(Color.init(hex: "#5b5b5b"))
//                            Text(String(self.noOfCompanies))
//                                .font(.system(size: 35, weight: .bold))
//                                .foregroundColor(Color.init(hex: "#4b4b4b"))
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.yellow)
//                        .cornerRadius(10)
//                        .padding()
