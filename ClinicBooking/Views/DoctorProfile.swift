//
//  DoctorProfile.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI

struct DoctorProfile: View {
    var doctorDetail: Doctor?
    @State private var selectedDate = Date()
    @State private var timeSessions = ["Morning", "Afternoon", "Evening", "Night"]
    @State private var selectedTimeSession = "Morning"
    @State var selectedTimeState: String?
    var morningTimes = ["08-09 AM", "09-10 AM", "10-11 AM", "11-12 AM"]
    var noonTimes = ["12-01 PM", "01-02 PM", "02-03 PM", "03-04 PM"]
    var eveningTimes = ["04-05 PM", "05-06 PM", "06-07 PM", "07-08 PM"]
    var nightTimes = ["08-09 PM", "09-10 PM", "10-11 PM", "11-12 PM"]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {
                headerView
                    .padding(.top, 15)
                appointmentView
            }
            .navigationTitle(Texts.docProfile.description)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    var headerView: some View {
        VStack {
            HStack {
                ImageCircle(icon: doctorDetail?.image ?? "user", radius: 50, circleColor: Color.doctorBG)
                VStack(alignment: .leading, spacing: 10) {
                    Text(doctorDetail?.name ?? "")
                        .font(.customFont(style: .bold, size: .h16))
                    Text(doctorDetail?.specialist ?? "")
                        .font(.customFont(style: .medium, size: .h15))
                        .foregroundColor(.gray)
                    HStack {
                        Image("star").resizable()
                            .frame(width: 15, height: 15)
                        Text(doctorDetail?.rating ?? "")
                            .font(.customFont(style: .medium, size: .h15))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 10)
                }
                Spacer()
            }
            .padding(.horizontal)
            VStack (alignment: .leading, spacing: 15) {
                Text(Texts.docBiography.description)
                    .font(.customFont(style: .bold, size: .h15))
                    .multilineTextAlignment(.leading)
                Text(doctorDetail?.about ?? "")
                    .font(.customFont(style: .medium, size: .h15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: UIScreen.main.bounds.width - 30)
            .padding()
            Spacer()
        }
    }

    var appointmentView: some View {
        VStack(alignment: .leading) {
            Text(Texts.schedules.description)
                .font(.customFont(style: .bold, size: .h15))
                .multilineTextAlignment(.leading)
            HStack {
                DatePicker("Date", selection: $selectedDate, in: Date()..., displayedComponents: .date)
                    .font(.customFont(style: .medium, size: .h15))
            }
            .padding(.top, 15)
            Text(Texts.chooseTimes.description)
                .font(.customFont(style: .bold, size: .h15))
                .multilineTextAlignment(.leading)
                .padding(.top, 15)
            Picker("Choose Time", selection: $selectedTimeSession) {
                ForEach(timeSessions, id: \.self) { selected in
                    VStack {
                        Text(selected)
                    }
                }
            }
            .pickerStyle(.segmented)
            .background(Color.appBlue.opacity(0.2))
            .frame(maxHeight: 60)
            .padding(.bottom, 10)

            switch selectedTimeSession {
            case TimeSessions.morning.rawValue:
                timeSessionView(morningTimes, TimeSessions.morning.rawValue)
            case TimeSessions.noon.rawValue:
                timeSessionView(noonTimes, TimeSessions.noon.rawValue)
            case TimeSessions.evening.rawValue:
                timeSessionView(eveningTimes, TimeSessions.evening.rawValue)
            case TimeSessions.night.rawValue:
                timeSessionView(nightTimes, TimeSessions.night.rawValue)
            default:
                timeSessionView(morningTimes, TimeSessions.morning.rawValue)
            }

            Button{

            } label: {
                Text(Texts.bookAppointment.description)
                    .font(.customFont(style: .bold, size: .h17))
            }
            .buttonStyle(BlueButtonStyle(height: 60, color: .appBlue))
            .padding(.top, 15)
        }
        .frame(width: UIScreen.main.bounds.width - 30)
    }

    private func timeSessionView(_ timeSession: [String],_ title: String) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("\(title) Schedule")
                .font(.customFont(style: .medium, size: .h15))
            HStack(spacing: 10) {
                ForEach(0..<timeSession.count, id: \.self) { attribute in
                    Button {
                        self.selectedTimeState = timeSession[attribute]
                        print("Attr pressed")
                    } label: {
                        Text(timeSession[attribute])
                            .foregroundColor(self.selectedTimeState == timeSession[attribute] ? Color.white : Color.black)
                            .font(.customFont(style: .medium, size: .h12))
                            .padding(10)
                    }
                    .background(self.selectedTimeState == timeSession[attribute] ? Color.appBlue : Color.white)
                    .cornerRadius(10)

                }
            }
        }
        .padding(.top, 10)
        .frame(width: UIScreen.main.bounds.width - 30, height: 120)
        .background(Color.appBlue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

enum TimeSessions: String {
    case morning = "Morning"
    case noon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}

#Preview {
    DoctorProfile()
}
