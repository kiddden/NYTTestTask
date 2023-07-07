//
//  NYTError.swift
//  NYTTestTask
//
//  Created by Eugene Ned on 06.07.2023.
//

import Foundation

enum NYTError: String, Error {
    case invalidEndpoint = "Invalid endpoint. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server is invalid. Please try again."
    case errorDecoding = "Decoding error"
    case errorRetreivingCache = "Error while loading from cache"
}
