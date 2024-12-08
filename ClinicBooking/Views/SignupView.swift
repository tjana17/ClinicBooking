//
//  SignupView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    enum Field: Hashable {
        case firstName
        case lastName
        case emailField
        case passwordField
    }
    @FocusState private var focusedField: Field?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image("logo").resizable()
                        .frame(width: 90, height: 90)
                        .aspectRatio(contentMode: .fit)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(Texts.medClinic.description)
                            .font(.customFont(style: .bold, size: .h24))
                        Text(Texts.bookDoctor.description)
                            .font(.customFont(style: .medium, size: .h15))
                    }
                }
                Spacer()
                VStack(spacing: 20) {
                    if let message = viewModel.validationMessage {
                        Text(message)
                            .foregroundColor(.red)
                            .font(.customFont(style: .medium, size: .h15))
                            .padding()
                    }
                    HStack(spacing: -10) {
                        CustomTextField(placeholder: Texts.firstName.description, text: $viewModel.firstName)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .firstName)
                            .onTapGesture {
                                viewModel.clearValidationMessage()
                            }
                            .onSubmit {
                                focusedField = .lastName
                            }
                        CustomTextField(placeholder: Texts.lastName.description, text: $viewModel.lastName)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .lastName)
                            .onTapGesture {
                                viewModel.clearValidationMessage()
                            }
                            .onSubmit {
                                focusedField = .emailField
                            }
                    }

                    CustomTextField(placeholder: Texts.enterEmail.description, text: $viewModel.email)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .emailField)
                        .onTapGesture {
                            viewModel.clearValidationMessage()
                        }
                        .onSubmit {
                            focusedField = .passwordField
                        }
                    CustomTextField(placeholder: Texts.enterPassword.description, text: $viewModel.password, isSecure: true)
                        .padding(.bottom, 10)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .passwordField)
                        .onTapGesture {
                            viewModel.clearValidationMessage()
                        }
                        .onSubmit {
                            focusedField = nil
                        }

                    Button {
                        print("Signup tapped!")
                        Task {
                            await viewModel.signup()
                            if viewModel.shouldNavigateToSignIn {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text(Texts.signup.description)
                            .foregroundColor(.white)
                            .font(.customFont(style: .bold, size: .h17))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.appBlue)
                            .cornerRadius(30)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                    }
                    Button {
                        print("Login tapped!")
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack(spacing: 10) {
                            Text(Texts.loginAccountMessage.description)
                                .font(.customFont(style: .medium, size: .h15))
                                .foregroundColor(.black)
                            Text(Texts.login.description)
                                .foregroundColor(Color.appBlue)
                                .underline()
                                .font(.customFont(style: .bold, size: .h17))
                        }
                    }
                }
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    SignupView()
}
