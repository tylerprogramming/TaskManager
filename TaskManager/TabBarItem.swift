//
//  TabBarItem.swift
//  TaskManager
//
//  Created by Tyler Reed on 10/19/22.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favorites, profile
    
    var iconName: String {
        switch self {
            case .home: return "house"
            case .favorites: return "heart"
            case .profile: return "person"
        }
    }
    
    var title: String {
        switch self {
            case .home: return "Home"
            case .favorites: return "Favorites"
            case .profile: return "Profile"
        }
    }
    
    var color: Color {
        switch self {
            case .home: return Color.red
            case .favorites: return Color.blue
            case .profile: return Color.green
        }
    }
}
