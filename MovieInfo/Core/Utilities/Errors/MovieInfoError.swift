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
            return "Не удалось загрузить данные."
        case .requestError:
            return "Ошибка запроса."
        case .statusParseError:
            return "Не удалось обработать ответ сервера."
        case .parseErrorDataFail:
            return "Не удалось обработать данные."
        case .parseConfigsDataFail:
            return "Неудалось обработать данные по конфигурациям API."
        case .parseMovieListDataFail:
            return "Неудалось обработать данные со списком фильмов."
        case .parseGenresListDataFail:
            return "Неудалось обработать данные со списком жанров."
        case .parseCertificationListFail:
            return "Неудалось обработать данные со списком сертификации."
        case .unknownError:
            return "Неизвестная ошибка."
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

