//
//  AddFamilyMemberView.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import SwiftUI
import PhotosUI
import iPhoneNumberField
import FirebaseAuth

struct EditProfileView: View {
    enum Field: Hashable {
        case firstName
        case lastName
        case height
        case weight
        case age
        case phoneNumber
    }
    @State var defaults = UserDefaults.standard.value(AppUser.self, forKey: "userDetails")
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var height: String = ""
    @State var weight: String = ""
    @State var age: String = ""
    @State var bloodGroup: String = ""
    @State var phoneNumber: String = ""
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Environment(\.presentationMode) var presentationMode
    var bloodGroups = ["Blood Group", "O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"]
    @State private var selectedBloodGroup : String = "Blood Group"
    @FocusState private var focusedField: Field?
    @State var isEditing: Bool = false
    @State private var selectedPhotoData: Data?
    @State var imageURL: String = ""
    @StateObject private var userViewModel = UserViewModel()


    var disableForm: Bool {
        firstName.count < 4 || lastName.count < 1 || height.count < 1 || weight.count < 1 || age.count < 1
        || phoneNumber.count < 9
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    PhotosPicker("Select Profile Picture", selection: $avatarItem, matching: .images)

                    if imageURL == "" {
                        avatarImage?
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        AsyncImage(
                            url: URL(string: defaults?.imageURL ?? ""),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    .clipShape(Circle())
                            },
                            placeholder: {
                                if defaults?.imageURL == "" {
                                    Image("user").resizable()
                                        .frame(width: 100, height: 100)
                                } else {
                                    ProgressView()
                                }
                            })
                    }

                    HStack(spacing: -15) {
                        CustomTextField(placeholder: defaults?.firstName ?? "", text: $firstName)
                            .submitLabel(.next)
                            .disabled(true)
                            .focused($focusedField, equals: .firstName)
                            .onSubmit {
                                focusedField = .lastName
                            }
                        CustomTextField(placeholder: defaults?.lastName ?? "", text: $lastName)
                            .submitLabel(.next)
                            .disabled(true)
                            .focused($focusedField, equals: .lastName)
                            .onSubmit {
                                focusedField = .height
                            }
                    }
                    CustomTextField(placeholder: defaults?.email ?? "", text: $email)
                        .disabled(true)
                    CustomTextField(placeholder: Texts.heightInInch.description, text: $height)
                        .keyboardType(.numbersAndPunctuation)
                        .submitLabel(.next)
                        .focused($focusedField, equals: .height)
                        .limitInputLength(value: $height, length: 5)
                        .onSubmit {
                            focusedField = .weight
                        }
                    CustomTextField(placeholder: Texts.weightInKG.description, text: $weight)
                        .keyboardType(.numberPad)
                        .limitInputLength(value: $weight, length: 3)
                        .focused($focusedField, equals: .weight)
                    HStack(spacing: -15) {
                        CustomTextField(placeholder: Texts.age.description, text: $age)
                            .limitInputLength(value: $age, length: 2)
                            .focused($focusedField, equals: .age)
                            .keyboardType(.numberPad)
                        Spacer()
                        Picker("Select your blood group", selection: $selectedBloodGroup) {
                            ForEach(bloodGroups, id: \.self) { group in
                                Text(group)
                            }
                        }
                        .frame(width: 150)
                    }
                    iPhoneNumberField("(000) 000-0000", text: $phoneNumber, isEditing: $isEditing, formatted: true)
                                .flagHidden(false)
                                .flagSelectable(true)
                                .font(UIFont(size: 18, weight: .medium, design: .rounded))
                                .maximumDigits(10)
                                .clearButtonMode(.whileEditing)
                                .onClear { _ in isEditing.toggle() }
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.lightGray, lineWidth: 2)
                                )
                                .padding()
                    Spacer()
                    Button {
                        Task {
                         await uploadDetails()
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label(Texts.updateProfile.description, systemImage: "person.crop.circle.fill.badge.plus")
                    }
                    .disabled(disableForm)
                    .buttonStyle(disableForm ? BlueButtonStyle(height: 44, color: Color.gray.opacity(0.1)) : BlueButtonStyle(height: 44, color: Color.appBlue))
                    .padding()

                }
                .onAppear {
                    firstName = defaults?.firstName ?? ""
                    lastName = defaults?.lastName ?? ""
                    email = defaults?.email ?? ""
                    height = defaults?.height ?? ""
                    weight = defaults?.weight ?? ""
                    age = defaults?.age ?? ""
                    imageURL = defaults?.imageURL ?? ""
                    selectedBloodGroup = defaults?.bloodGroup ?? "Blood Group"
                    phoneNumber = defaults?.phoneNumber ?? ""
                }
                .padding()
                .onTapGesture {
                    self.hideKeyboard()
                }
            }
            .navigationTitle(Texts.updateProfile.description)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: avatarItem) {
                Task {
                    if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                        if let selectedPhotoData,
                           let image = UIImage(data: selectedPhotoData) {
                            ImageUploader.uploadImage(image: image) { response in
                                imageURL = response
                                print("Image URL= \(imageURL)")
                            }
                        }
                    }
                    if let loaded = try? await avatarItem?.loadTransferable(type: Image.self) {
                        avatarImage = loaded
                    } else {
                        print("Failed to pick image")
                    }
                }
            }
        }
    }
    func hideKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
   }
    func uploadDetails() async {
        let appuser = AppUser(password: defaults?.password ?? "",
                           email: email,
                           firstName: firstName,
                           lastName: lastName,
                           createdAt: Date(),
                           height: height,
                           weight: weight,
                           age: age,
                           bloodGroup: selectedBloodGroup,
                           phoneNumber: phoneNumber,
                           imageURL: imageURL)

        debugPrint("Family Members == \(String(describing: appuser))")
        if let user = Auth.auth().currentUser {
            // Save to Firebase using the authenticated user's UID
            await FireStoreManager.shared.updateUserDetails(
                user.uid,
                dataModel: appuser
            ) { success in
                if success {
                    print("User details saved successfully in Firestore.")
                } else {
                    print("Failed to save User details to Firestore.")
                }
            }
        } else {
            print("No authenticated user found.")
        }
    }
}

#Preview {
    AddFamilyMemberView()
}
