//
//  NotificationExtension.swift
//  CryptoDashboard
//
//  Created by Shai Ariman on 21/05/2019.
//  Copyright © 2019 Shai Ariman. All rights reserved.
//

import Foundation

public extension Notification.Name {
    static let onImageArrived = Notification.Name("onImageArrived")
}

public extension Notification {
    struct userInfoKey {
        public static let url = "url"
        public static let image = "image"
    }
}
