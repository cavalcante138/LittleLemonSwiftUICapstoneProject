//
//  ButtonLemon.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 20/02/23.
//

import SwiftUI

struct ButtonLemon: View {

    var title: String = "Button"
    var action: () -> Void = {}
    var color: String = "LittleLemonPrimaryColor"
    var foregroundColor: Color = .white

    var body: some View {
                Button(action: {
                    action()
                }, label: {
                    Text(title)
                        .foregroundColor(foregroundColor)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color(color))
                        .cornerRadius(8)
                        
                        
                }).frame(maxWidth: .infinity)
    }
}

struct ButtonLemon_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLemon(
            title: "Button",
            action: {},
            color: "LittleLemonPrimaryColor",
            foregroundColor: .white
        )
    }
}
