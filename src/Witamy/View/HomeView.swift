//
//  HomeView.swift
//  Witamy
//
//  Created by savio sailas on 23/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Welcome!")
        Text("Authentication is successful")
            .navigationBarItems(trailing: Button("Logout") {
                UserDefaults.standard.removeObject(forKey: "jwt_token")
            })
    }
}

#Preview {
    HomeView()
}
