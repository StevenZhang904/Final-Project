//
//  data.swift
//  Final Project
//
//  Created by 张泽华 on 2020/4/21.
//  Copyright © 2020 张泽华. All rights reserved.
//

import Foundation
public class SwiftOxfordAPI{
//    private struct results: Codable{
//        var lexicalEntries: [lexicalEntries]
//    }
    private struct Results: Codable{
        var id: String
        var lexicalEntries: [lexicalEntries]
    }
    private struct lexicalEntries: Codable{
        var entries: [entries]
    }
    private struct entries: Codable{
        var senses: [senses]
    }
    private struct senses: Codable{
        var definitions: [String]
    }

    
    let appId = "d068abad"
    let appKey = "68e38766d0409e0ca71fa2bbb96d466b"
    let language = "en-gb"
    var word = "ace"
    let fields = "definitions"
    let strictMatch = "false"
   
    
    func getData(){
        let word_id = word.lowercased()
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v2/entries/\(language)/\(word_id)?fields=\(fields)&strictMatch=\(strictMatch)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        print("\(request)")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let response = response,
                let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
                //print(response)
                print("***\(jsonData)")
            }
            else {
                print(error)
                print(NSString.init(data: data!, encoding: String.Encoding.utf8.rawValue))
            }
            do{
                let returned = try JSONDecoder().decode(Results.self, from: data!)
                print("***")
                print("*** \(returned)")
                //print("*** \(returned.lexicalEntries[0].entries[0].senses[0].definitions[0])")
//                self.definitions = self.wordArray + returned.lexicalEntries
            }
            catch{
                print("error could not decode JSON \(error)")
            }
        }).resume()
    }
}
