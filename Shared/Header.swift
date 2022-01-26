//
//  Header.swift
//  SoojiUI
//
//  Created by NiC on 1/25/22.
//

import SwiftUI

struct Header: View {
    var body: some View {
        Text("Remem..What?")
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold))
            .padding(EdgeInsets.init(top: 20, leading: 1, bottom: 20, trailing: 1))
            .frame(minWidth: 0 ,maxWidth: .infinity, alignment: .center)
            .background(Color.init(hex: "#2b2b2b"))
            .cornerRadius(15)
            .padding()
        
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
