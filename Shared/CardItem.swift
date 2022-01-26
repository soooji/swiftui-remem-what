//
//  CardItem.swift
//  SoojiUI
//
//  Created by NiC on 1/25/22.
//

import SwiftUI

struct CardItem: View {
    let title: String
    let date: Date

   var body: some View {
       HStack(alignment: .top) {
           VStack(alignment: .leading,spacing: 5) {
               Text(title)
                   .font(.system(size: 20, weight: .bold))
               Text(date.formatted())
                   .font(.system(size: 16, weight: .medium))
           }
           Spacer()
       }
       .foregroundColor(.white)
       .frame(maxWidth: .infinity)
       .padding()
       .background(Color(hex: "#3b3b3b"))
       .cornerRadius(10)
   }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(title: "Go To School", date: Date.now)
    }
}
