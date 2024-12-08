//
//  SplashScreen.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 27/11/24.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale = 0.7
    @Binding var isActive: Bool
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Image("logo")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                Text("Clinic Booking")
                    .font(.customFont(style: .bold, size: .h24))
            }.scaleEffect(scale)
                .onAppear{
                    withAnimation(.easeIn(duration: 0.7)) {
                        self.scale = 0.9
                    }
                }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}
