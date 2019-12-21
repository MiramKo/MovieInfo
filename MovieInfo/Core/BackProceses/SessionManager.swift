//
//  SessionManager.swift
//  MovieInfo
//
//  Created by Михаил Костров on 15/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

//TODO - error parser
import Foundation

class SessionManager {
    
    static let shared = SessionManager()
    
    private var session: String? = nil
    
    init() {
        
    }
    
    public func checkSession() {
        let keychainValue = KeyChainManager.getValue(forKey: "session")
        guard let session = keychainValue.value
            else {
                self.createSession()
                return
            }
        self.session = session
    }
    
    public func getSession() -> String? {
        self.checkSession()
        return self.session
    }
    
    public func updateSession() {
        self.createSession()
    }
    
    private func createSession() {
        let api = MDBAPIFactory.getAPI(withType: .guestSession)
        api.request() { [weak self] (value, error) in
            guard let value = value as? SessionModel,
            let session = value.getValue() else { return }
            self?.session = session
            KeyChainManager.set(value: session, forKey: "session")
            print("session from net: \(self?.session ?? "")")
        }
    }
    
}
