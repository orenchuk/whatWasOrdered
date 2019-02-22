//
//  SpreadsheetValues.swift
//  whatWasOrdered
//
//  Created by Yevhenii Orenchuk on 2/21/19.
//  Copyright © 2019 Yevhenii Orenchuk. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

class SpreadsheetValues {
    
    let spreadsheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
    var service: GTLRSheetsService
    
    init(service: GTLRSheetsService) {
        self.service = service
        self.service.authorizer = GIDSignIn.sharedInstance().currentUser.authentication.fetcherAuthorizer()
    }
    
    func fetchValues(range: String, majorDimension: String = "DIMENSION_UNSPECIFIED", complitionHandler: @escaping (GTLRSheets_ValueRange?) -> ()) {
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range: range)
        query.majorDimension = majorDimension
        
        service.executeQuery(query) { (serviceTicket, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let result = response as? GTLRSheets_ValueRange
                complitionHandler(result)
            }
        }
    }
}
