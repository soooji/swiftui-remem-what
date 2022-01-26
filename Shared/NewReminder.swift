//
//  NewReminder.swift
//  SoojiUI
//
//  Created by NiC on 1/26/22.
//

import SwiftUI

struct NewReminder: View {
    @State private var title: String = ""
    @State private var reminderDate = Date()
    
    var onSubmit: (Reminder) -> Void
    var onCancel: () -> Void
    
    func submitReminder() {
        let newReminder = Reminder(title: title, date: reminderDate)
        self.title = ""
        self.reminderDate = Date()
        onSubmit(newReminder)
    }
    
    var body: some View {
        VStack {
            
            TextField("Reminder Title ...", text: $title)
                .multilineTextAlignment(.leading)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(15)
                .background(Color.init(hex: "#3b3b3b"))
                .cornerRadius(10)
            
            DatePicker(selection: $reminderDate, in: Date()..., displayedComponents: .date) {
                Text("Reminde me on")
            }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .background(Color.init(hex: "#3b3b3b"))
                .cornerRadius(10)
        
            HStack {
                Button(action: {
                    submitReminder()
                }) {
                    Text("Add Reminder")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "1b1b1b"))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                }
                
                Button(action: {
                    onCancel()
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "1b1b1b"))
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                }
                
            }
            
        
        }
            .frame(maxWidth: .infinity)
    }
        
}
//
//struct NewReminder_Previews: PreviewProvider {
//    func onSubmit(rem: Reminder) {}
//    func onCancel() {}
//    
//    static var previews: some View {
//        NewReminder(onSubmit: onSubmit, onCancel: onCancel)
//    }
//}
