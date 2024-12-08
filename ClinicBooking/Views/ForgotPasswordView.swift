//
//  ForgotPasswordView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    var body: some View {
        VStack {
            Text(Texts.forgotPassword.description)
                .font(.customFont(style: .bold, size: .h17))
                .padding([.top, .bottom], 15)
            Divider()
            Spacer()
            CustomTextField(placeholder: Texts.enterEmail.description, text: $viewModel.email)
            Spacer()
            if let message = viewModel.validationMessage {
                Text(message)
                    .foregroundColor(.red)
                    .padding()
            }
            Button(Texts.sendResetEmail.description) {
                Task {
                    await viewModel.resetPassword()
                }
            }
            .buttonStyle(BlueButtonStyle(height: 44, color: Color.appBlue))
            .padding()
        }
        .padding()

    }
}

#Preview {
    ForgotPasswordView()
}
