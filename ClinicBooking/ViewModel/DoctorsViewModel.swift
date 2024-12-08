//
//  DoctorsViewModel.swift
//  ClinicBooking
//
//  Created by Janarthanan Kannan on 03/09/24.
//

import Foundation

@MainActor
class DoctorsViewModel: ObservableObject {


    func loadJson(fileName: String) -> DoctorsList? {
       let decoder = JSONDecoder()
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let person = try? decoder.decode(DoctorsList.self, from: data)
       else {
            return nil
       }
        return person
    }

}
