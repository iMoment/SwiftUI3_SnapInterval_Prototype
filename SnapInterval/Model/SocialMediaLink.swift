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
    SocialMediaLink(title: "Tumblr", logo: "pencil.circle.fill"),
    SocialMediaLink(title: "Twitter", logo: "trash.square.fill"),
    SocialMediaLink(title: "Instagram", logo: "folder.circle.fill"),
    SocialMediaLink(title: "Google", logo: "paperplane.circle.fill"),
    SocialMediaLink(title: "Dribbble", logo: "tray.circle.fill"),
    SocialMediaLink(title: "Pinterest", logo: "doc.circle.fill")
]
