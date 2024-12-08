//
//  ServicesView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI

struct ServicesView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    Spacer()
                        .padding(.top, 15)
                    LazyVGrid(columns: columns, spacing: 35) {
                        ForEach(0..<AppConstants.serviceListImages.count, id: \.self) { index in
                            ServicesCardView(
                                image: AppConstants.serviceListImages[index].description,
                                title: AppConstants.serviceListImages[index].description.capitalized
                            )
                        }
                    }
                }
            }
            .navigationTitle("Find your Doctor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ServicesView()
}
