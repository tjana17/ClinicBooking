//
//  SavedDoctors.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 27/11/24.
//

import SwiftUI

struct SavedDoctors: View {
    @StateObject var viewModel: DoctorsViewModel = DoctorsViewModel()
    @State var doctors: [Doctor] = []
    @State var doctorDetail : Doctor?
    @State private var showDoctorProfile: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    savedDoctorsView
                    Spacer()
                }
            }
            .navigationTitle("Saved Doctors")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            let data = viewModel.loadJson(fileName: "doctors")
            self.doctors.removeAll()
            if let data = data {
                for doc in data.doctors {
                    if doc.isSaved == true {
                        let meme = Doctor(
                            doctorID: doc.doctorID,
                            name: doc.name,
                            specialist: doc.specialist,
                            degree: doc.degree,
                            image: doc.image,
                            position: doc.position,
                            languageSpoken: doc.languageSpoken,
                            about: doc.about,
                            contact: doc.contact,
                            address: doc.address,
                            rating: doc.rating,
                            isPopular: doc.isPopular,
                            isSaved: doc.isSaved
                        )
                        self.doctors.append(meme)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDoctorProfile, destination: { DoctorProfile(doctorDetail: doctorDetail) })
    }

    var savedDoctorsView: some View {
        VStack {
            ForEach(0..<doctors.count, id: \.self) { index in
                DoctorsCardView(
                    name: doctors[index].name,
                    speciality: doctors[index].specialist,
                    rating: doctors[index].rating,
                    fee: "$50.99",
                    image: doctors[index].image,
                    btnAction: {
                        showDoctorProfile =  true
                        self.doctorDetail = doctors[index]
                    }
                )
                .onTapGesture {
                    showDoctorProfile =  true
                    self.doctorDetail = doctors[index]
                }
            }
        }
    }
}

#Preview {
    SavedDoctors()
}
