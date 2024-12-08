//
//  ContentView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 01/09/24.
//

import SwiftUI

struct HomeDashboard: View {
    @State private var selectedIndex: Int = 0
    @State private var isShowServices: Bool = false
    @State private var showDoctorProfile: Bool = false
    @StateObject var viewModel: DoctorsViewModel = DoctorsViewModel()
    @State var doctors: [Doctor] = []
    @State var doctorDetail : Doctor?
    @State var defaults = UserDefaults.standard.value(AppUser.self, forKey: "userDetails")

    var body: some View {
        NavigationStack {
            tabView
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    headerView
                }
            }
        }
        .navigationDestination(isPresented: $showDoctorProfile, destination: { DoctorProfile(doctorDetail: doctorDetail) })
        .navigationDestination(isPresented: $isShowServices, destination: { ServicesView() })
        .onAppear {
            let data = viewModel.loadJson(fileName: "doctors")
            self.doctors.removeAll()
            if let data = data {
                for doc in data.doctors {
                    if doc.isPopular == true {
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
    }

    var headerView: some View {
        HStack {
            Spacer()
                .frame(width: 15)
            Button(action: {

            }, label: {
                AsyncImage(
                    url: URL(string: defaults?.imageURL ?? ""),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 35, maxHeight: 35)
                            .clipShape(Circle())
                    },
                    placeholder: {
                        if defaults?.imageURL == "" {
                            Image("user").resizable()
                                .frame(width: 35, height: 35)
                        } else {
                            ProgressView()
                        }
                    })
            })
            VStack(alignment: .leading) {
                Text(Texts.welcomeBack.description)
                    .font(.customFont(style: .medium, size: .h13))
                Text("Mr.\(defaults?.firstName ?? "") \(defaults?.lastName ?? "")!")
                    .font(.customFont(style: .bold, size: .h15))
            }
            Spacer()
            Button(action: {

            }, label: {
                Image(systemName: "magnifyingglass.circle")
                    .font(.customFont(style: .medium, size: .h24))
                    .foregroundColor(Color.appBlue)
            })
            Button(action: {

            }, label: {
                Image(systemName: "bell.circle")
                    .font(.customFont(style: .medium, size: .h24))
                    .foregroundColor(Color.appBlue)
            })
        }
        .frame(width: UIScreen.main.bounds.width - 20, height: 60)
    }

    var tabView: some View {
        TabView(selection: $selectedIndex) {
            NavigationStack() {
                homeContent
                    .padding()
            }
            .tabItem {
                Image(systemName: "house.fill")
                    .renderingMode(.template)
            }
            .tag(0)
            NavigationStack {
                AppointmentsView()
                    .navigationTitle("Appointments")
            }
            .tabItem {
                Image(systemName: "calendar")
                    .renderingMode(.template)
            }
            .tag(1)
            NavigationStack {
                SavedDoctors()
                    .navigationTitle("Saved Doctors")
            }
            .tabItem {
                Image(systemName: "heart")
                    .renderingMode(.template)
            }
            .tag(2)
            NavigationStack() {
                UserProfileView()
                    .navigationTitle("Profile")
            }
            .tabItem {
                Label("", systemImage: "person.fill")
            }
            .tag(3)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {

            UITabBar.appearance().backgroundColor = UIColor.systemBackground
        }
        .accentColor(Color.appBlue)
    }

    var homeContent: some View {
        ScrollView(.vertical) {
            searchHeaderView
                .padding(.bottom, 15)
            servicesView
                .padding(.bottom, 15)
            popularDoctorsView
        }
    }

    var searchHeaderView: some View {
        ZStack {
            Spacer()
                .padding(.top)
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.appBlue)
                .frame(width: UIScreen.main.bounds.width - 30, height: 160)
            HStack(spacing: 50) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(Texts.lookingForDoctors.description)
                        .font(.customFont(style: .medium, size: .h17))
                        .foregroundColor(.white)
                    Button {

                    } label: {
                        Text(Texts.searchFor.description)
                            .font(.customFont(style: .medium, size: .h15))
                            .foregroundColor(.black)
                            .frame(width: 120, height: 40)
                            .background(.white)
                            .clipShape(Capsule())
                    }
                }
                Image("home-doctor").resizable()
                    .frame(width: 150, height: 150)
                    .offset(x: 0, y: 5)
            }
        }
    }

    var servicesView: some View {
        VStack {
            HStack {
                Text(Texts.findYourDoctor.description)
                    .font(.customFont(style: .bold, size: .h18))
                Spacer()
                Button {
                    isShowServices = true
                } label: {
                    Text(Texts.seeAll.description)
                        .font(.customFont(style: .medium, size: .h15))
                }
            }
            Spacer()
                .padding(.top, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    ForEach(0..<AppConstants.serviceListImages.count, id: \.self) { index in
                        ServicesCardView(
                            image: AppConstants.serviceListImages[index].description,
                            title: AppConstants.serviceListImages[index].description.capitalized
                        )
                    }
                }
            }
        }
    }

    var popularDoctorsView: some View {
        VStack {
            HStack {
                Text(Texts.popularDoctors.description)
                    .font(.customFont(style: .bold, size: .h18))
                Spacer()
                Button {

                } label: {
                    Text(Texts.seeAll.description)
                        .font(.customFont(style: .medium, size: .h15))
                }
            }
            Spacer()
                .padding(.top, 10)
//            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(0..<doctors.count, id: \.self) { index in
                        DoctorsCardView(
                            name: doctors[index].name,
                            speciality: doctors[index].specialist,
                            rating: doctors[index].rating,
                            fee: "$50.99", 
                            image: doctors[index].image,
                            btnAction: {
                                showDoctorProfile = true
                                self.doctorDetail = doctors[index]
                            }
                        )
                        .onTapGesture {
                            showDoctorProfile =  true
                            self.doctorDetail = doctors[index]
                        }
                    }
//                }
            }
//            NavigationLink(destination: DoctorProfile(), isActive: $showDoctorProfile) { EmptyView() }
        }
    }

}

#Preview {
    HomeDashboard()
}
