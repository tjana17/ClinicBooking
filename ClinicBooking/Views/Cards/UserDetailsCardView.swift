//
//  UserDetailsCardView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import SwiftUI

struct UserDetailsCardView: View {
    var image: String
    var title: String
    var value: String
    var body: some View {
        VStack(spacing: 10) {
            ImageCircle(icon: image, radius: 38, circleColor: .lightBlue)
            Text(title)
                .font(.customFont(style: .medium, size: .h14))
                .foregroundStyle(.gray)
            Text(value)
                .font(.customFont(style: .bold, size: .h16))
        }
    }
}

#Preview {
    UserDetailsCardView(image: "height", title: "Height", value: "5.8 in")
}
