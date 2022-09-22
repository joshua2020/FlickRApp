//
//  NetworkManager.swift
//  FlickRApp
//
//  Created by Joshua on 21/09/2022.
//

import Foundation
import UIKit

class NetworkManager {
    let apiKey = CommonConstants.Api.apiKey
    let baseUrl = CommonConstants.Api.baseApiUrl

    private var dataTask: URLSessionDataTask?
    private let urlSession = URLSession.shared

    func getSearchedPictureData(searchString: String, completion: @escaping (Result<FlickrModel, Error>) -> Void) {
        
        guard let flickrURL = buildFlickrURLFor(search: searchString) else { return AlertBuilder().showError(message: "Unable to Build URL Request") }

        dataTask = URLSession.shared.dataTask(with: flickrURL) { (data, response, error) in
            if let error = error {
                    completion(.failure(error))
                AlertBuilder().showError(message: error.localizedDescription)
                print("DataTask Error: \(error.localizedDescription)")
            }
            guard let response = response as? HTTPURLResponse else {
                AlertBuilder().showError(message: "No Response")
                print("No Response")
                return
            }
            print("Response status code: \(response.statusCode)")

            guard let data = data else {
                AlertBuilder().showError(message: "Empty Data")
                print("Empty Data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(FlickrModel.self, from: data)
                print(jsonData)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                DispatchQueue.main.async {
                AlertBuilder().showError(message: error.localizedDescription)
                completion(.failure(error))
                }
            }
        }
        dataTask?.resume()
    }

    fileprivate func buildFlickrURLFor(search: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.flickr.com"
        urlComponents.path = "/services/feeds/photos_public.gne"
        let format = URLQueryItem(name: "format", value: "json")
        let search = URLQueryItem(name: "tags", value: search)
        let callback = URLQueryItem(name: "nojsoncallback", value: "1")
        urlComponents.queryItems = [format, search, callback]
        guard let fullURL = urlComponents.url else {
            return nil
        }
        return fullURL
    }
}
