//
//  CustomTextField.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    @State var isSecure: Bool = false
    @State var showPassword: Bool = false
    @FocusState var isFieldFocus: FieldToFocus?
    @ViewBuilder func secureField() -> some View {
        if self.showPassword {
            TextField(placeholder, text: $text)
                .font(.customFont(style: .medium, size: .h16))
                .focused($isFieldFocus, equals: .textField)
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60, alignment: .center)
        } else {
            SecureField(placeholder, text: $text)
                .font(.customFont(style: .medium, size: .h16))
                .focused($isFieldFocus, equals: .secureField)
                .keyboardType(.default)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 60, alignment: .center)
        }
    }

    var body: some View {
        if isSecure {
            HStack {
                secureField()
                if !text.isEmpty {
                    Button(action: {
                        self.showPassword.toggle()
                    }, label: {
                        ZStack(alignment: .trailing){
                            Color.clear
                                .frame(maxWidth: 29, maxHeight: 60, alignment: .center)
                            Image(systemName: self.showPassword ? "eye.slash.fill" : "eye.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Color.init(red: 160.0/255.0, green: 160.0/255.0, blue: 160.0/255.0))
                        }
                    })
                }
            }
            .padding(.horizontal, 15)
            .background(.white)
            .font(.customFont(style: .medium, size: .h16))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.lightGray, lineWidth: 2)
            )
            .padding(.horizontal, 15)
            //            SecureField(placeholder, text: $text)
            //                .padding()
            //                .background(.white)
            //                .font(.customFont(style: .medium, size: .h16))
            //                .overlay(RoundedRectangle(cornerRadius: 30)
            //                    .stroke(Color.lightGray, lineWidth: 2)
            //                )
            //                .padding(.horizontal)
        } else {
            TextField(
                placeholder,
                text: $text
            )
            .padding()
            .autocapitalization(.none)
            .background(.white)
            .font(.customFont(style: .medium, size: .h16))
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.lightGray, lineWidth: 2)
            )
            .padding(.horizontal)
        }
    }

    enum FieldToFocus {
        case secureField, textField
    }
}

#Preview {
    CustomTextField(placeholder: "test", text: .constant("Hello"))
}

struct TextFieldLimitModifier: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifier(value: value, length: length))
    }
}
