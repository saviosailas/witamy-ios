//
//  LoginViewModel.swift
//  Witamy
//
//  Created by savio sailas on 21/12/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoginButtonEnabled: Bool = true
    @Published var showHomeScreen: Bool = false
    
    init (username: String, password: String) {
        self.username = username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        self.password = password
    }
    
    convenience init() {
        self.init(username: "admin@gmail.com", password: "Password12")
    }
    
    func authenticateUsingPassword() {
        if !isLoginButtonEnabled { return }
        isLoginButtonEnabled =  false
        self.username = username.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard let url  = URL(string: "https://witnamy.pythonanywhere.com/api/v1/login") else {
            isLoginButtonEnabled = true
            showAuthenticationError()
            return
        }
        var postRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        postRequest.httpMethod = "POST"
        postRequest.setValue("application/json", forHTTPHeaderField: "accept")
        let parameters: [String: String] = [
            "email": username,
            "password": password
        ]
        let stringParameters = parameters.map { (key, value) in
            return "\(key)=\(value)"
        }.joined(separator: "&")
        let encodedParameters = stringParameters.data(using: .utf8)
        postRequest.httpBody = encodedParameters
        
        let loginTask = URLSession.shared.dataTask(with: postRequest) { [weak self] data, responseMetaData, error in
            guard let self = self else { return }
            guard let data else { showAuthenticationError(); return }
            let authenticationResponse = try? JSONDecoder().decode(AuthenticationResponse.self, from: data)
            guard let authenticationResponse else { showAuthenticationError(); return }
            
            if authenticationResponse.message == AuthenticationResponse.Message.success.rawValue {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    showHomeScreen = true
                    DispatchQueue.global().async {
                        UserDefaults.standard.set(authenticationResponse.jwt, forKey: "jwt_token")
                    }
                    print(authenticationResponse.message)
                    print(authenticationResponse.jwt)
                }
            }
            // handle Authentication failure
            showAuthenticationError()
        }
        loginTask.resume()
    }
    
    func showAuthenticationError() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            isLoginButtonEnabled = true
        }
    }
}


struct AuthenticationResponse: Codable {
    enum Message: String, Decodable {
        case success = "login successful"
        case failure = "login failed"
    }
    
    let message: String
    let jwt: String
            
    enum CodingKeys: String, CodingKey {
        case message
        case jwt = "jwt_token"
    }
}
