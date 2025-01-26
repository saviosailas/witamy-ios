//
//  InfoCardView.swift
//  Witamy
//
//  Created by savio sailas on 26/01/25.
//

import SwiftUI
struct InfoCardView: View {
    
    @StateObject var viewModel: InfoCardViewModel
        
    var body: some View {
        HStack {
            HStack(alignment: .center, spacing: 0) {
                
                Image(systemName: viewModel.sysImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 26)
                    .padding(.leading, 5)
                
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        Text(viewModel.title)
                            .font(.title2)
                        Spacer()
                        if let date = viewModel.date {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(.yellow)
                                .clipShape(Capsule())
                                .padding(.trailing, 3)
                        }
                    }
                    .padding(.bottom, 8)
                    Text(viewModel.subtitle)
                        .font(.subheadline)
                    
                } .foregroundStyle(.primary)
                    .padding(.leading)
                    .padding(.vertical, 0)
                    .frame(width: 320, height: 100)
                
            }
            .background(viewModel.background)
            .compositingGroup()
            .shadow(color: .gray, radius: 0, x: 0, y: 1)
            .shadow(color: .gray, radius: 0, x: 0, y: -1)
            .shadow(color: .gray, radius: 0, x: 1, y: 0)
            .shadow(color: viewModel.ribonColor, radius: 0, x: -10, y: 0)
            .clipShape(RoundedRectangle(cornerRadius: viewModel.cornerRadius))
            
            
        }
        
    }
}
#Preview {
    ScrollView {
        VStack {
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
            InfoCardView(viewModel: InfoCardViewModel())
        }
    }
   .shadow(color: .gray, radius: 0, x: 0, y: 1)
   .shadow(color: .gray, radius: 0, x: 0, y: -1)
   .shadow(color: .gray, radius: 0, x: 1, y: 0)
   .shadow(color: .gray, radius: 0, x: -10, y: 0)
}
class InfoCardViewModel: ObservableObject {
    @Published var title: String
    @Published var subtitle: String
    @Published var date: Date?
    @Published var sysImage: String
    @Published var ribonColor: Color
    @Published var background: Color
    @Published var cornerRadius: CGFloat
    
    init(
        title: String,
        subtitle: String,
        date: Date? = nil,
        sysImage: String,
        ribonColor: Color,
        background: Color,
        cornerRadius: CGFloat
    ) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.sysImage = sysImage
        self.ribonColor = ribonColor
        self.background = background
        self.cornerRadius = cornerRadius
    }
    
    convenience init() {
        self.init(
            title: "Witamy support video call",
            subtitle: "All video call is encrypted by nothing",
            date: Date.now.advanced(by: 5000),
            sysImage: ["heart", "star.fill", "bell", "pencil", "camera", "trash", "person.fill", "gear", "calendar", "magnifyingglass"].randomElement() ?? "gift",
            ribonColor: .indigo,
            background: .white,
            cornerRadius: CGFloat(15.0)
        )
    }
}
