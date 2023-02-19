//
//  Menu.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 19/02/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack {
               Text("Little Lemon")
                   .font(.title)
                   .fontWeight(.bold)
               Text("Chicago")
                   .font(.subheadline)
                   .foregroundColor(.gray)
               Text("Little Lemon offers a wide variety of delicious and healthy food options that are made fresh each day. You can browse the menu by category to find your favorites, and we offer a seamless ordering experience through the app.")
                   .font(.body)
                   .multilineTextAlignment(.center)
                   .padding()
               List {
                   // Add menu items here
               }
           }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
