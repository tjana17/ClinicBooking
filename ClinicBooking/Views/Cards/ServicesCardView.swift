//
//  ServicesCardView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI

struct ServicesCardView: View {
    var image: String
    var title: String

    var body: some View {
        VStack(spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color.lightBlue)
                    .frame(width: 80, height: 80)
                Image(image).resizable()
                    .frame(width: 45, height: 45)
            }
            Text(title)
                .font(.customFont(style: .medium, size: .h15))
        }
    }
}

#Preview {
    ServicesCardView(image: "cardiology", title: "Cardiology")
}
