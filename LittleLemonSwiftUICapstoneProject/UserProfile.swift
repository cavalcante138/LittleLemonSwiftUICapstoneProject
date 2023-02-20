//
//  UserProfile.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 19/02/23.
//

import SwiftUI

struct UserProfile: View {
    
    @Environment(\.presentationMode) var presentation
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State private var isLoggedIn = false

    @State var firstNameConfig = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    @State var lastNameConfig = UserDefaults.standard.string(forKey: kLastName) ?? ""
    @State var emailConfig = UserDefaults.standard.string(forKey: kEmail) ?? ""
    @State var phoneNumber = ""
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Header(
                isProfilePicturePresent: false)
                VStack(alignment: .leading) {
                Text("Personal information")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                HStack(alignment: .center) {
                Image("profile-image-placeholder")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                ButtonLemon(
                    title: "Change",
                    action: {

                    },
                    color: "grey",
                    foregroundColor: .black
                )
                ButtonLemon(
                    title: "Remove",
                    action: {

                    },
                    color: "LittleLemonPrimaryColor",
                    foregroundColor: .white
                )
                Spacer()
                }

                    Text("First name")
                       .foregroundColor(.gray)
                        .font(.caption2)
                      .fontWeight(.bold)
                    TextField("", text: $firstNameConfig)
                           .padding(10)
                            .disabled(true)
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("grey"), lineWidth: 1))
                    Text("Last name")
                       .foregroundColor(.gray)
                        .font(.caption2)
                      .fontWeight(.bold)
                    TextField("", text: $lastNameConfig)
                           .padding(10)
                            .disabled(true)
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("grey"), lineWidth: 1))
                    Text("Email")
                      .foregroundColor(.gray)
                       .font(.caption2)
                      .fontWeight(.bold)
                    TextField("", text: $emailConfig)
                           .padding(10)
                            .disabled(true)
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("grey"), lineWidth: 1))

                    Text("Phone number")
                       .foregroundColor(.gray)
                        .font(.caption2)
                       .fontWeight(.bold)
                    TextField("", text: $phoneNumber)
                           .padding(10)
                           .disabled(true)
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("grey"), lineWidth: 1))


                      // Button("Logout") {
                      //     UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                      //     self.presentation.wrappedValue.dismiss()
                      // }
                }.padding()
                HStack(alignment: .center){
                ButtonLemon(title: "Logout", action: {
                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }, color: "secondarycolor", 
                foregroundColor: .black)
                Spacer()
                }.padding(EdgeInsets(top: 20, leading: 0, bottom: 40, trailing: 0))
                Spacer()
                HStack(alignment: .center){
                Spacer()
                ButtonLemon(title: "Discard changes", action: {
                    print("Discard changes")
                }, color: "grey",
                foregroundColor: .black)
                Spacer()
                ButtonLemon(title: "Save changes", action: {
                    print("Save changes")
                }, color: "LittleLemonPrimaryColor",
                foregroundColor: .white)
                Spacer()
                }

                

            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
