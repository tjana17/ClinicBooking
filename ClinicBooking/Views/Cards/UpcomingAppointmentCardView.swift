//
//  UpcomingAppointmentCardView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 27/09/24.
//

import SwiftUI

struct UpcomingAppointmentCardView: View {
    var address: String
    var date: String
    var time: String
    var name: String
    var speciality: String
    var image: String
    let randomColor: Color = .random
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(address)
                .lineLimit(2)
                .font(.customFont(style: .condensedMedium, size: .h18))
            HStack {
                Text(date)
                    .font(.customFont(style: .condensedMedium, size: .h28))
                Spacer()
                Text(time)
                    .font(.customFont(style: .condensedMedium, size: .h28))
            }
            .padding(.bottom, 15)
            HStack(spacing: 15) {
                ImageCircle(icon: image, radius: 40, circleColor: Color.doctorBG)
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.customFont(style: .bold, size: .h14))
                    Text(speciality)
                        .font(.customFont(style: .medium, size: .h14))
                }
            }
        }
        .padding()
        .background(randomColor.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(maxWidth: .infinity)

    }
}
#Preview {
    UpcomingAppointmentCardView(
        address: "Address",
        date: "7 June",
        time: "9:00 AM",
        name: "Janarthanan Kannan",
        speciality: "General Medicine",
        image: "edwin"
    )
}
