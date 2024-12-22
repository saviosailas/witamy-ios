//
//  ContentView.swift
//  Witamy
//
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel = LoginViewModel()
    var body: some View {
        VStack {
            TextField("user name", text: $viewModel.username)
                .textContentType(.emailAddress)
                .padding()
                .border(Color.gray, width: 2)
            SecureField("password", text: $viewModel.password)
                .padding()
                .border(Color.gray, width: 2)
            Button {
                viewModel.authenticateUsingPassword()
            } label: {
                HStack {
                    Spacer()
                    Text("Login")
                        .bold()
                        .foregroundColor(Color.white)
                        .padding()
                    if !viewModel.isLoginButtonEnabled {
                        ProgressView()
                    }
                    Spacer()
                }
                .background(viewModel.isLoginButtonEnabled ? Color.blue : Color.gray)
                .border(Color.gray, width: 2)
                .padding(.top)
            }
            .navigationLinkAndDestination(isPresented: $viewModel.showHomeScreen) {
                VStack {
                    Text("Home screen")
                }
            }
        }
        .padding(.horizontal)
        .naviagtionViewAndStack()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct NavigationViewAndStack: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
}

extension View {
    func naviagtionViewAndStack() -> some View {
        modifier(NavigationViewAndStack())
    }
}

struct NavigationLinkAndDestination<V>: ViewModifier where V: View {
    @Binding var isPresented: Bool
    @ViewBuilder var destination: () -> V
    
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .navigationDestination(isPresented: $isPresented) {
                    destination()
                }
        }
    }
}

extension View {
    func navigationLinkAndDestination<V>(isPresented: Binding<Bool>, @ViewBuilder destination: @escaping () -> V) -> some View where V: View {
        modifier(NavigationLinkAndDestination(isPresented: isPresented, destination: destination))
    }
}
