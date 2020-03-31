//
//  ApiService.swift
//  Youtube
//
//  Created by Ashwini shalke on 31/03/20.
//  Copyright © 2020 Ashwini Shalke. All rights reserved.
//

import UIKit
class ApiService:NSObject {
    
    static let sharedInstance = ApiService()
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosFromURLString(urlString: "\(baseURL)home.json", completion: completion)
    }
    
    func fetchTrending(completion: @escaping([Video]) -> ()){
        fetchVideosFromURLString(urlString: "\(baseURL)trending.json", completion: completion)
    }
    
    func fetchSubscription(completion: @escaping([Video]) -> ()){
        fetchVideosFromURLString(urlString: "\(baseURL)subscriptions.json", completion: completion)
    }
    
    
    func fetchVideosFromURLString(urlString: String, completion : @escaping ([Video]) ->() ){
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            do {
                let videosArray = try JSONDecoder().decode([Video].self,  from: data)
                DispatchQueue.main.async {
                    completion(videosArray)
                }
            } catch let jsonErr {
                print("Unable to fetch Data",jsonErr)
            }
        }.resume()
    }
}
