//
//  Onboarding.swift
//  LittleLemonSwiftUICapstoneProject
//
//  Created by Lucas Cavalcante on 19/02/23.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State private var showError = false
    @State private var errorMessage = "An error occurred."
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
            Header(
            isProfilePicturePresent: false)
                        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Little Lemon")
                        .fontWeight(.bold)
                        .foregroundColor(Color("secondarycolor"))
                        .font(Font.custom("MarkaziText-Medium", size: 32, relativeTo: .title))
                    Text("Chicago")
                        .font(Font.custom("MarkaziText-Medium", size: 26, relativeTo: .subheadline))
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.caption)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 26, trailing: 0))
                        .multilineTextAlignment(.leading)
                }
                Image("banner")
                .resizable()
                // image cover
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                // add border and corner radius
                .cornerRadius(20)

            }}  .padding()
                .background(Color("LittleLemonPrimaryColor"))
                .foregroundColor(Color.white)
                NavigationLink(
                       destination: Home(),
                       isActive: $isLoggedIn) {
                       EmptyView()
                }

                VStack(spacing: 5){
                
                Text("Welcome to Little Lemon App!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("LittleLemonPrimaryColor"))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                VStack(alignment: .leading, spacing: 5){
                Text("First Name")
                       .foregroundColor(.gray)
                       .font(.caption2)
                       .fontWeight(.bold)
                TextField("First Name", text: $firstName)
                       .padding(10)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("grey"), lineWidth: 1))
                Text("Last Name")
                       .foregroundColor(.gray)
                       .font(.caption2)
                       .fontWeight(.bold)
                TextField("Last Name", text: $lastName)
                       .padding(10)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("grey"), lineWidth: 1))
                Text("Email")
                       .foregroundColor(.gray)
                       .font(.caption2)
                       .fontWeight(.bold)
                TextField("Email", text: $email)
                       .padding(10)
                       .autocapitalization(.none)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("grey"), lineWidth: 1))

                }

                ButtonLemon(title: "Register", action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        if isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        } else {
                            errorMessage = "Invalid email."
                            showError = true
                        }
                    } else {
                        errorMessage = "Please fill in all fields."
                        showError = true
                    }
                })
                }.padding()
                Spacer()
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
             }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
