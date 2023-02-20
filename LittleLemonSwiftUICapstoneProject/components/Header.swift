//
//  Header.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 20/02/23.
//

import SwiftUI

struct Header: View {

    var isProfilePicturePresent: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            Circle()
               .frame(width: 40, height: 40)
               .background(Color.white)
               .foregroundColor(Color.white)
            Spacer()
            HStack(alignment: .center){
              Image("logo-icon")
                 .resizable()
                  .scaledToFit()
                  .frame(width: 40, height: 40) 
              Text("Little Lemon")
                .textCase(.uppercase)
                .foregroundColor(Color("LittleLemonPrimaryColor"))
                .font(Font.custom("MarkaziText-Medium", size: 24, relativeTo: .title))
            } 
            Spacer()
            if(isProfilePicturePresent){
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
            }else{
            Circle()
               .frame(width: 40, height: 40)
               .background(Color.white)
               .foregroundColor(Color.white)
            }  
        }
        .padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(isProfilePicturePresent: true)
    }
}
