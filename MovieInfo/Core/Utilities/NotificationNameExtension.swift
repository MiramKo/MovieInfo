//
//  NotificationNameExtension.swift
//  MovieInfo
//
//  Created by Михаил Костров on 14/11/2019.
//  Copyright © 2019 Михаил Костров. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let newDataObtained = Notification.Name("newDataObtained")
    static let firstStartConfReceived = Notification.Name("firstStartConfReceived")
    static let firstStartGenresRecived = Notification.Name("firstStartGenresRecived")
    static let preparationsDone = Notification.Name("preparationsDone")

}