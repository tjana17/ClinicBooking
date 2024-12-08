//
//  SplashViewCoordinator.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 27/11/24.
//

import SwiftUI

struct SplashViewCoordinator: View {
    @State private var isActive = false
    var body: some View {
        if isActive {
            AppRootView()
        } else {
            SplashScreen(isActive: $isActive)
        }
    }
}

#Preview {
    SplashViewCoordinator()
}
