//
//  SocialMediaLink.swift
//  SnapInterval
//
//  Created by Stanley Pan on 2022/01/28.
//

import SwiftUI

// MARK: Social Media Link model
struct SocialMediaLink: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var logo: String
}

var links = [
    SocialMediaLink(title: "Tumblr", logo: "tumblr"),
    SocialMediaLink(title: "Twitter", logo: "twitter"),
    SocialMediaLink(title: "Instagram", logo: "instagram"),
    SocialMediaLink(title: "Google", logo: "google"),
    SocialMediaLink(title: "Dribbble", logo: "dribbble"),
    SocialMediaLink(title: "Pinterest", logo: "pinterest")
]
