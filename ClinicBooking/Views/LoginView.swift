//
//  LoginView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import SwiftUI
import ProgressHUD

struct LoginView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    enum Field: Hashable {
        case emailField
        case passwordField
    }
    @FocusState private var focusedField: Field?

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
                    CustomTextField(placeholder: Texts.enterEmail.description, text: $viewModel.email)
                        .textInputAutocapitalization(.never)
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
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .submitLabel(.done)
                        .focused($focusedField, equals: .passwordField)
                        .onTapGesture {
                            viewModel.clearValidationMessage()
                        }
                        .onSubmit {
                            focusedField = nil
                        }
                    Button {
                        print("Forget password tapped!")
                        viewModel.showingResetPasswordSheet = true
                    }  label: {
                        Text(Texts.forgotPassword.description)
                            .font(.customFont(style: .medium, size: .h16))
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .foregroundColor(Color.appBlue)
                    Button {
                        print("Login tapped!")
                        ProgressHUD.animate("Logging In...", .ballVerticalBounce)
                        ProgressHUD.colorAnimation = .systemBlue
                        Task {
                            if await viewModel.signIn() {
                                await viewModel.getUserDetails()
                                viewModel.isShowingHomeView = true
                                ProgressHUD.dismiss()
                            }
                        }
                    } label: {
                        Text(Texts.login.description)
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
                        print("Sigup tapped!")
                        viewModel.isShowingSignUpScreen = true
                    } label: {
                        HStack(spacing: 10) {
                            Text(Texts.accountMessage.description)
                                .font(.customFont(style: .medium, size: .h15))
                                .foregroundColor(.black)
                            Text(Texts.signup.description)
                                .foregroundColor(Color.appBlue)
                                .underline()
                                .font(.customFont(style: .bold, size: .h17))
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .ignoresSafeArea(.keyboard)
        .navigationDestination(isPresented: $viewModel.isShowingSignUpScreen) {
            SignupView()
        }
        .navigationDestination(isPresented: $viewModel.isShowingHomeView) {
            HomeDashboard()
                .navigationBarBackButtonHidden(true)
        }
        .sheet(isPresented: $viewModel.showingResetPasswordSheet) {
            ForgotPasswordView()
                .presentationDetents([.medium])
        }
        .onAppear {

        }
    }
}

#Preview {
    LoginView()
}
