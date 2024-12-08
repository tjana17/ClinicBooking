//
//  ImageCircle.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI

struct ImageCircle: View {

    let icon: String
    let radius: CGFloat
    let circleColor: Color
    var squareSide: CGFloat {
        2.0.squareRoot() * radius
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(circleColor)
                .frame(width: radius * 2, height: radius * 2)
                .overlay(Circle().stroke(Color.white, lineWidth: 6))
            // Use this implementation for an SF Symbol
//            Image(systemName: icon)
//                .resizable()
//                .aspectRatio(1.0, contentMode: .fit)
//                .frame(width: squareSide, height: squareSide)
//                .foregroundColor(imageColor)

            // Use this implementation for an image in your assets folder.
            Image(icon)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
                .frame(width: squareSide, height: squareSide)
        }
    }
}
