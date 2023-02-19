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
                NavigationLink(
                       destination: Home(),
                       isActive: $isLoggedIn) {
                       EmptyView()
                }
                
                TextField("First Name", text: $firstName)
                       .padding(10)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("Border"), lineWidth: 1))
                TextField("Last Name", text: $lastName)
                       .padding(10)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("Border"), lineWidth: 1))
                TextField("Email", text: $email)
                       .padding(10)
                       .background(RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("Border"), lineWidth: 1))
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        // Optional email validation check
                        if isValidEmail(email) {
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            isLoggedIn = true
                        } else {
                            // Show an error message for invalid email
                            errorMessage = "Invalid email."
                            showError = true
                        }
                    } else {
                        // Show an error message for empty fields
                        errorMessage = "Please fill in all fields."
                        showError = true
                    }
                }) {
                    Text("Register")
                        .font(.system(size: 16, weight: .bold))
                           .foregroundColor(.white)
                           .frame(maxWidth: .infinity, minHeight: 40)
                           .padding()
                           .background(RoundedRectangle(cornerRadius: 8)
                                           .stroke(Color("LittleLemonPrimaryColor"), lineWidth: 1)
                                           .background(Color("LittleLemonPrimaryColor")))
                           .scaleEffect(1.0)
                           .border(Color.black)
                }
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
