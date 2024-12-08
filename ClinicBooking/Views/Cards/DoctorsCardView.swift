//
//  DoctorsCardView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI

struct DoctorsCardView: View {
    var name: String
    var speciality: String
    var rating: String
    var fee: String
    var image: String
    var btnAction: () -> Void
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
            HStack(spacing: 15) {
                ImageCircle(icon: image, radius: 40, circleColor: Color.doctorBG)
                VStack(alignment: .leading, spacing: 8) {
                    Text(name)
                        .font(.customFont(style: .bold, size: .h14))
                    Text(speciality)
                        .font(.customFont(style: .medium, size: .h13))
                    HStack {
                        Image("star").resizable()
                            .frame(width: 15, height: 15)
                        Text(rating)
                            .font(.customFont(style: .medium, size: .h13))
                    }
                }
//                .padding(.trailing, 10)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Fee \(fee)")
                        .font(.customFont(style: .medium, size: .h13))
                    Button {
                        /// Button action for book now
                        btnAction()
                    } label: {
                        Text(Texts.bookNow.description)
                            .font(.customFont(style: .medium, size: .h11))
                            .foregroundColor(.white)
                            .frame(width: 70, height: 40)
                            .background(colorScheme == .dark ? Color.appGreen : Color.appBlue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .frame(width: 85)
            }
            .frame(width: UIScreen.main.bounds.width - 30)
            Divider()
    }
}

#Preview {
    DoctorsCardView(name: "Name", speciality: "Speciality", rating: "4.5 (2200)", fee: "$50.99", image: "edwin") {
        print("Btn clicked")
    }
}
