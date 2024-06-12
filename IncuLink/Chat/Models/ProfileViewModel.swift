//
//  ProfileViewModel.swift
//  IncuLink
//
//  Created by Ankit Rajput on 06/06/24.
//

import Foundation

enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
