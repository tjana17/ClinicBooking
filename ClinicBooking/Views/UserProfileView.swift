//
//  UserProfileView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 02/09/24.
//

import SwiftUI
import ProgressHUD

struct UserProfileView: View {
    @State var addMember: Bool = false
    @State var showEditProfile: Bool = false
    @State var defaults = UserDefaults.standard.value(AppUser.self, forKey: "userDetails")
    @StateObject private var viewModel = AuthenticationViewModel()
    @StateObject private var userViewModel = UserViewModel()
    @State private var showSignoutAlert = false

    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    profileHeaderView
                    familyMemberView
                    Spacer()
                        .navigationTitle("Profile")
                        .navigationBarTitleDisplayMode(.inline)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
        }

        .onAppear{
            Task {
               await userViewModel.getFamilyMembers()
            }
        }

    }

    var profileHeaderView: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .center) {
                    Color(Color.appBlue.opacity(0.2))
                    VStack(spacing: 15) {
//                        Image("user").resizable()
//                            .frame(width: 100, height: 100)
                        AsyncImage(
                            url: URL(string: defaults?.imageURL ?? ""),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 120, maxHeight: 120)
                                    .clipShape(Circle())
                            },
                            placeholder: {
                                if defaults?.imageURL == "" {
                                    Image("user").resizable()
                                        .frame(width: 120, height: 120)
                                } else {
                                    ProgressView()
                                }
                            })
                        Text("\(defaults?.firstName ?? "") \(defaults?.lastName ?? "")")
                            .foregroundColor(.black)
                            .font(.customFont(style: .bold, size: .h17))
                        Text("\(defaults?.email.lowercased() ?? "")")
                            .foregroundColor(.black)
                            .foregroundStyle(.black)
                            .font(.customFont(style: .medium, size: .h15))
                        HStack(spacing: 15) {
                            Button {
                                print("Edit profile tapped!")
                                showEditProfile = true
                            } label: {
                                Label(
                                    title: {
                                        Text(Texts.editProfile.description)
                                            .font(.customFont(style: .bold, size: .h14))
                                    },
                                    icon: { Image(systemName: "pencil") }
                                )
                            }
                            .buttonStyle(BorderButtonStyle(borderColor: Color.gray, foregroundColor: .black, height: 60, background: .clear))
                            Button {
                                print("Signout Tapped!")
                                showSignoutAlert = true
                            } label: {
                                Label(
                                    title: { 
                                        Text(Texts.signOut.description)
                                            .font(.customFont(style: .bold, size: .h14))
                                    },
                                    icon: { Image(systemName: "power") }
                                )
                            }
                            .buttonStyle(BorderButtonStyle(borderColor: Color.appBlue, foregroundColor: .black, height: 60, background: .clear))
                        }
                        .padding(.horizontal, 30)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                }
                .padding(.bottom, 20)
                HStack(spacing: 15) {
                    UserDetailsCardView(image: "height", title: Texts.height.description, value: "\(defaults?.height ?? "") in")
                    UserDetailsCardView(image: "weight", title: Texts.weight.description, value: "\(defaults?.weight ?? "") KG")
                    UserDetailsCardView(image: "age", title: Texts.age.description, value: "\(defaults?.age ?? "")")
                    UserDetailsCardView(image: "blood", title: Texts.blood.description, value: "\(defaults?.bloodGroup ?? "")")
                }
                .alert("Are you sure you want to logging out?", isPresented: $showSignoutAlert) {
                    Button("OK") {
                        viewModel.signOut()
                        UserDefaults.standard.removeObject(forKey: "userDetails")
                    }
                    Button("Cancel", role: .cancel) {}
                }
                .navigationDestination(isPresented: $viewModel.showSignInView) {
                    LoginView()
                        .navigationBarBackButtonHidden(true)
                }
                .navigationDestination(isPresented: $addMember) {
                    AddFamilyMemberView()
                }
                .navigationDestination(isPresented: $showEditProfile) {
                    EditProfileView()
                        .transition(.slide)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        defaults = UserDefaults.standard.value(AppUser.self, forKey: "userDetails")
                    }
                }
            }
        }
    }

    var familyMemberView: some View {
        VStack {
            HStack {
                Text(Texts.familyMembers.description)
                    .font(.customFont(style: .bold, size: .h18))
                Spacer()
                Button {
                    /// Button Action
                    addMember = true
                } label: {
                    Label(Texts.addNew.description, systemImage: "plus")
                }
                .buttonStyle(BlueButtonStyle(height: 35, color: Color.appBlue))
                .frame(width: 120)
            }
            Spacer()
                .padding(.top, 10)
            if let member = userViewModel.familyMembers?.members {
                ForEach(0..<member.count, id: \.self) { index in
                    FamilyMembersListView(
                        imageUrl: member[index].imageURL,
                        name: (member[index].firstName) + " " + (member[index].lastName),
                        phoneNumber: member[index].phoneNumber,
                        bloodGroup: member[index].bloodGroup,
                        age: member[index].age,
                        height: member[index].height,
                        weight: member[index].weight
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    UserProfileView()
}

struct FamilyMembersListView: View {
    var imageUrl: String
    var name, phoneNumber, bloodGroup, age, height, weight: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                AsyncImage(
                    url: URL(string: imageUrl),
                    content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 50, maxHeight: 50)
                            .clipShape(Circle())
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                VStack(alignment: .leading, spacing: 12) {
                    Text(name)
                        .font(.customFont(style: .medium, size: .h15))
                    Text("\(phoneNumber)  -  Blood Group: \(bloodGroup)")
                        .font(.customFont(style: .medium, size: .h14))
                        .foregroundStyle(.gray)
                    HStack(spacing: 12) {
                        Text("Age: \(age)")
                            .font(.customFont(style: .medium, size: .h13))
                            .foregroundStyle(.gray)
                        Divider()
                        Text("Height: \(height) in")
                            .font(.customFont(style: .medium, size: .h13))
                            .foregroundStyle(.gray)
                        Divider()
                        Text("Weight: \(weight) KGS")
                            .font(.customFont(style: .medium, size: .h13))
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        Divider()
    }
}
