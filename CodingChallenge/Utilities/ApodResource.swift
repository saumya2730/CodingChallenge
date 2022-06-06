//
//  ApodResource.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import Foundation

struct ApodResource
{
    func getApod(apiRequest: APIServiceRequest, completion : @escaping (_ result: APIServiceResponse?,_ error:String?) -> Void)
    {
        let url = ApiEndpoints(date: apiRequest.date).apodURL
        
        if let apodUrl = URL(string: url) {
            
            let httpUtility = HttpUtility()
            
            httpUtility.getApiData(requestUrl: apodUrl, resultType: APIServiceResponse.self) { (apodApiResponse,error)  in
                _ = completion(apodApiResponse,error)
            }
        }
    }
    
}
