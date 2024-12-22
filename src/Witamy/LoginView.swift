//
//  ContentView.swift
//  Witamy
//
//

import SwiftUI

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
        TextField("user name", text: $username)
            .textContentType(.emailAddress)
            .padding()
            .border(Color.gray, width: 2)
        SecureField("password", text: $password)
            .padding()
            .border(Color.gray, width: 2)
            Button {
                print("send to server")
            } label: {
                HStack {
                    Spacer()
                    Text("Login")
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                }
                .background(Color.blue)
                .border(Color.gray, width: 2)
                .padding(.top)
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
