//
//  ApiHomeViewModel.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import Foundation

let favoritesKey = "Favorites"

class ApiHomeViewModel {
    
    // MARK: - Variables
    var date: String?
    var title: String?
    var explanation: String?
    var url: String?
    var media_type: GlobalConstants.MediaType?
    let cache = NSCache<NSString, APIServiceResponse>()
    var queryDate : NSString?
    
    // MARK: - API Call
    // API Call
    func callApodApi(queryDate: Date, completion : @escaping (_ isSuccess: Bool,_ error:String?) -> Void) {
        
        self.updateQueryDate(queryDate: queryDate)
        guard let queryDate = self.queryDate else {
            return
        }
        let apodRequest = APIServiceRequest(date: queryDate as String)
        //Use ApodResource to call API
        let apodResource = ApodResource()
        apodResource.getApod(apiRequest: apodRequest) { [self] (apodApiResponse,error) in
            
            //Return the response to view get from apodResource
            if(error == nil && apodApiResponse != nil) {
                
                self.updateResponse(ApiResponse: apodApiResponse!)
                
                //If need to cache all requests
                //cache.setObject(apodApiResponse!, forKey: self.queryDate as NSString)
                cache.setObject(apodApiResponse!, forKey: queryDate as NSString)
                _ = completion(true,nil)
                
            } else {
                
                if let cachedResponse = cache.object(forKey: queryDate as NSString)  {
                    // Return Last API Cached Response
                    self.updateResponse(ApiResponse: cachedResponse)
                    _ = completion(true,nil)
                }
                // Also Return Error
                _ = completion(false,error)
            }
        }
    }
    
    // MARK: - Methods
    func updateQueryDate(queryDate: Date) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GlobalConstants.ApodDateFormat
        let dateString = dateFormatter.string(from: queryDate)
        self.queryDate = dateString as NSString
    }
    
    func updateResponse(ApiResponse:APIServiceResponse) {
        
        self.date = ApiResponse.date
        self.title = ApiResponse.title
        self.explanation = ApiResponse.explanation
        self.url = ApiResponse.url
        if(ApiResponse.media_type == GlobalConstants.MediaTypeImage) {
            self.media_type = .image
        }else {
            self.media_type = .video
        }
    }
    
    func addingToFav() {
        var favoritesArray: [APIServiceResponse] = []
        if let oldData = UserDefaults.standard.value(forKey: favoritesKey) as? Data, let oldDataArray = try? JSONDecoder().decode([APIServiceResponse].self, from: oldData){
            favoritesArray = oldDataArray
        }
        
        if let queryString = queryDate, let newData = (cache.object(forKey: queryString)) as? APIServiceResponse {
            favoritesArray.append(newData)
            guard let data  = try? JSONEncoder().encode(favoritesArray) else { return }
            UserDefaults.standard.set(data as Any, forKey: favoritesKey)
        }
    }
    
    func removeFromFav() {
        var currentDateResponse = APIServiceResponse()
        if let queryString = queryDate, let newData = (cache.object(forKey: queryString)) as? APIServiceResponse {
            currentDateResponse = newData
        }
        
        if let oldData = UserDefaults.standard.value(forKey: favoritesKey) as? Data, var oldDataArray = try? JSONDecoder().decode([APIServiceResponse].self, from: oldData), !currentDateResponse.date.isEmpty {
            for (i,response) in oldDataArray.enumerated() where response.date == currentDateResponse.date {
                oldDataArray.remove(at: i)
            }
            guard let data  = try? JSONEncoder().encode(oldDataArray) else { return }
            UserDefaults.standard.set(data as Any, forKey: favoritesKey)
        }
    }
    
    func getFavSelectionStatus() -> Bool {
        var currentDateResponse = APIServiceResponse()
        if let queryString = queryDate, let newData = (cache.object(forKey: queryString)) {
            currentDateResponse = newData
        }
        
        if let oldData = UserDefaults.standard.value(forKey: favoritesKey) as? Data, let oldDataArray = try? JSONDecoder().decode([APIServiceResponse].self, from: oldData), !currentDateResponse.date.isEmpty {
            for (index,response) in oldDataArray.enumerated() where response.date == currentDateResponse.date {
                return true
            }
            
        }
        return false
    }
    
}
