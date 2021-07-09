//
//  DataFetcher.swift
//  PDFExpertUIKit
//
//  Created by Nazariy Vysokinskyi on 08.07.2021.
//

import Foundation

import GTMSessionFetcher
import GoogleAPIClientForREST

class DataFetcher {
    
    private struct Constants {
        static let spreadSheetID      = "1wDg1ZvDxA7nFzUJcl8B9Q5JiyIyny_44xwiOqNhYxZw"
        static let apiKey             = "AIzaSyDSE21FBc2H_Z-O8kqsHPAYhmGOCypi2wg"
    }
    
    // MARK: - PUBLIC INTERFACE
    
    func getFileTree() -> EntryNode {
        readSheet()
        return root
    }
    
    
    // MARK: - INTERNAL IMPLEMENTATION
    
    private let root = EntryNode(value: Entry(id: "", parentID: "", itemType: "d", itemName: "MainFolder"))
    private var fetchedResponse = [[String]]()
    
    func readSheet() {
        let service = GTLRSheetsService()
        service.apiKey = Constants.apiKey
        
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: Constants.spreadSheetID, range: "PDFexpert!A2:D38")
        
        service.executeQuery(query) { ticket, result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let data = result as? GTLRSheets_ValueRange
                self.fetchedResponse = data?.values as? [[String]] ?? [[""]]
                self.treeFromJsonResponse()
            }
        }
    }
    
    /// Initializes the tree from JSON response
    /// - Parameter response: JSON response array
    private func treeFromJsonResponse() {
        
        whileThereAreResponses: while !fetchedResponse.isEmpty {
            for element in fetchedResponse {
                let childEntry = Entry(id: element[0], parentID: element[1], itemType: element[2], itemName: element[3])
                let childNode = EntryNode(value: childEntry)
                
                if let parentID = childEntry.parentID {
                    if let parent = root.findParent(withID: parentID) {
                        parent.addChild(childNode)
                        fetchedResponse.removeFirst()
                    } else {
                        if fetchedResponse.count > 1 {
                            fetchedResponse.append(fetchedResponse.removeFirst())
                        } else {
                            break whileThereAreResponses
                        }
                    }
                } else {
                    root.addChild(childNode)
                    fetchedResponse.removeFirst()
                }
            }
        }
    }
}








///// Fetches JSON data from Google Sheet API
//private func fetchData() {
//    DispatchQueue.global(qos: .userInitiated).async {
//        let url = URL(string: "https://sheets.googleapis.com/v4/spreadsheets/1wDg1ZvDxA7nFzUJcl8B9Q5JiyIyny_44xwiOqNhYxZw/values/PDFexpert!A2:D38?key=\(Constants.apiKey)")!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "Unknown error")
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            if let jsonResponse = try? decoder.decode(JSONResponse.self, from: data) {
//                print("Json Response is ready")
//                self.fetchedResponse = jsonResponse.values
//                self.treeFromJsonResponse()
//            } else {
//                print("Unable to parse JSON data")
//            }
//        }.resume()
//    }
//
//}
