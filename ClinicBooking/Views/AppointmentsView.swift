//
//  AppointmentsView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 26/09/24.
//

import SwiftUI

struct AppointmentsView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text("Upcoming")
                            .font(.customFont(style: .bold, size: .h16))
                            .padding(.horizontal, 16)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(0..<3, id: \.self) { index in
                                    UpcomingAppointmentCardView(address: "North Masi Street, Madurai - 1.", date: "7 June", time: "9:00 AM", name: "Janarthanan Kannan", speciality: "General Medicine", image: "edwin")
                                        .frame(width: UIScreen.main.bounds.width - 30)
                                        .padding([.leading, .trailing], 16)
                                }
                            }
                        }
                        .scrollTargetBehavior(.paging)
                    }
                    .padding([.top, .bottom], 10)
                    VStack(alignment: .leading) {
                        Text("Past")
                            .font(.customFont(style: .bold, size: .h16))
                            .padding(.horizontal, 16)
                        ForEach(0..<3, id: \.self) { index in
                            PastAppointmetsCard(
                                image: "edwin",
                                name: "Janarthanan Kannan",
                                speciality: "General Medicine",
                                date: "7 June",
                                time: "10:00 AM"
                            )
                            .padding([.leading, .trailing], 16)
                            .padding(.bottom, 5)
                        }
                    }
                    Spacer()
                }
                .background(Color.lightGray.opacity(0.7))
            }
            .navigationTitle("Appointments")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AppointmentsView()
}
