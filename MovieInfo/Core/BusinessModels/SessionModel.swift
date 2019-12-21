//
//  SessionModel.swift
//  MovieInfo
//
//  Created by Михаил Костров on 16/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

class SessionModel: BusinessModelProtocol {
    
    private struct Session: Codable {
        let success: Bool
        let guest_session_id: String
        let expires_at: String
    }
    
    private var session: String? = nil
    
    init(withData data: Data) {
        do {
            let serialisedData = try JSONDecoder().decode(Session.self, from: data)
            self.session = serialisedData.guest_session_id
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func getValue() -> String? {
        return self.session
    }
}
