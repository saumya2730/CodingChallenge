//
//  ApodURL.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import Foundation

struct ApiEndpoints {
    
    let apodURL: String
    
    init(date:String) {
        self.apodURL = "\(GlobalConstants.API)&date=\(date)" //"https://\(GlobalConstants.getApodBaseURL())/planetary/apod?api_key=\(GlobalConstants.getAPIKey())&date=\(date)"
        
        
        // Change key from Global Constants
    }
    
}
