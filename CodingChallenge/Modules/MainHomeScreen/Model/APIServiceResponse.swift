//
//  APIServiceResponse.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import Foundation

// MARK: - APIServiceResponse
class APIServiceResponse : Codable {
    var date: String
    var title: String
    var explanation: String
    var url: String
    var media_type: String
    
    init() {
        self.date = ""
        self.title = ""
        self.explanation = ""
        self.url = ""
        self.media_type = ""
    }
    
    init(date:String,title: String,explanation: String,url: String,media_type: String) {
        
        self.date = date
        self.title = title
        self.explanation = explanation
        self.url = url
        self.media_type = media_type
    }
}
