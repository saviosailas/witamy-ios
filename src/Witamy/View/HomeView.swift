//
//  HomeView.swift
//  Witamy
//
//  Created by savio sailas on 23/12/24.
//

import SwiftUI

struct HomeView: View {
    
    let infoCard: InfoCardViewModel = InfoCardViewModel(title: "New machine", subtitle: "192.168.1.26 is added to network", date: Date.now, sysImage: "network", ribonColor: .blue, background: .white, cornerRadius: CGFloat(15.0))
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20)  {
                InfoCardView(viewModel: infoCard)
                Text("Welcome!")
                Text("Authentication is successful")
            }.padding()
        }
        .navigationBarItems(trailing: Button("Logout") {
            UserDefaults.standard.removeObject(forKey: "jwt_token")
        })
        .naviagtionViewAndStack()
    }
}

#Preview {
    HomeView()
}
