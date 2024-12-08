//
//  ButtonStyles.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 19/09/24.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    var height: CGFloat
    var color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .foregroundColor(.white)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
    }
}

struct BorderButtonStyle: ButtonStyle {
    var borderColor: Color
    var foregroundColor: Color
    var height: CGFloat
    var background: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .foregroundColor(foregroundColor)
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .background(background)
            .overlay(RoundedRectangle(cornerRadius: 30)
                .stroke(borderColor, lineWidth: 2))
    }
}
