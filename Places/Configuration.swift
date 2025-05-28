//
//  Configuration.swift
//  Places
//
//  Created by Fer on 28/05/2025.
//

import Foundation

enum Configuration {

    private static let assignmentURLKey = "AssignmentURL"
    
    static var assignmentURL: URL {
        guard let urlString = Bundle.main.infoDictionary?[assignmentURLKey] as? String,
              let url = URL(string: urlString) else {
            // If the URL is not configured correctly we really want to stop the app excecution here.
            // Any configuration problems like this will be catched by UI tests.
            preconditionFailure("The AssignmentURL is not configured correctly.")
        }
        return url
    }
}
