//
//  MovieInfoError.swift
//  MovieInfo
//
//  Created by Михаил Костров on 22/12/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

enum MovieInfoErrorType {

    case dataLoadFail 
    case requestError
    case statusParseError
    case parseErrorDataFail
    case parseConfigsDataFail
    case parseMovieListDataFail
    case parseGenresListDataFail
    case parseCertificationListFail
    case unknownError
    
    var code: Int {
        switch self {
        case .dataLoadFail:
            return 101
        case .requestError:
            return 102
        case .statusParseError:
            return 103
        case .parseErrorDataFail:
            return 104
        case .parseConfigsDataFail:
            return 105
        case .parseMovieListDataFail:
            return 106
        case .parseGenresListDataFail:
            return 107
        case .parseCertificationListFail:
            return 108
        case .unknownError:
            return 0
        }
    }
    
    var description: String {
        switch self {
        case .dataLoadFail:
            return NSLocalizedString("DATA_LOAD_FAIL", comment: "DATA_LOAD_FAIL")
        case .requestError:
            return NSLocalizedString("REQUEST_ERROR", comment: "REQUEST_ERROR")
        case .statusParseError:
            return NSLocalizedString("STATUS_PARSE_ERROR", comment: "STATUS_PARSE_ERROR")
        case .parseErrorDataFail:
            return NSLocalizedString("PARSE_ERROR_DATA_FAIL", comment: "PARSE_ERROR_DATA_FAIL")
        case .parseConfigsDataFail:
            return NSLocalizedString("PARSE_CONFIGS_DATA_FAIL", comment: "PARSE_CONFIGS_DATA_FAIL")
        case .parseMovieListDataFail:
            return NSLocalizedString("PARSE_MOVIE_LIST_DATA_FAIL", comment: "PARSE_MOVIE_LIST_DATA_FAIL")
        case .parseGenresListDataFail:
            return NSLocalizedString("PARSE_GENRES_LIST_DATA_FAIL", comment: "PARSE_GENRES_LIST_DATA_FAIL")
        case .parseCertificationListFail:
            return NSLocalizedString("PARSE_CERTIFICATION_LIST_FAIL", comment: "PARSE_CERTIFICATION_LIST_FAIL")
        case .unknownError:
            return NSLocalizedString("UNKNOWN_ERROR", comment: "UNKNOWN_ERROR")
        }
    }
}

class MovieInfoError: Error {
    
    let errorDescription: String
    let code: Int
    
    init(_ code: Int,_ description: String = "") {
        self.code = code
        switch code {
        case 7, 34:
            self.errorDescription = NSLocalizedString("ERROR_\(code)", comment: "ERROR_\(code)")
        default:
            self.errorDescription = description
        }
    }

    init(_ type: MovieInfoErrorType) {
        code = type.code
        errorDescription = type.description
    }
    
}

