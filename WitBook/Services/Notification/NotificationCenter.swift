//
//  NotificationCenter.swift
//  WitBook
//
//  Created by rbkusser on 29.12.2024.
//

import UIKit

class BaseNotification: RawRepresentable, Equatable {

    typealias RawValue = String
    let rawValue: RawValue
    var name: Notification.Name { .init(rawValue: rawValue) }

    required init(rawValue: String = #function) {
        self.rawValue = rawValue
    }
    
    convenience init(name: Notification.Name) {
        self.init(rawValue: name.rawValue)
    }
}

extension BaseNotification {

    static var didBecomeActive: BaseNotification { .init(name: UIApplication.didBecomeActiveNotification) }
    static var willResignActive: BaseNotification { .init(name: UIApplication.willResignActiveNotification) }
    static var didEnterBackground: BaseNotification { .init(name: UIApplication.didEnterBackgroundNotification) }
    static var willEnterForeground: BaseNotification { .init(name: UIApplication.willEnterForegroundNotification) }
    static var screenCapturedDidChange: BaseNotification { .init(name: UIScreen.capturedDidChangeNotification) }
}


protocol BaseNotificationManagerDelegate: AnyObject {
    
    func performOnTrigger(_ notification: BaseNotification, object: Any?, userInfo: [AnyHashable: Any]?)
}

class BaseNotificationManager {
    
    private let notificationCenter = NotificationCenter.default
    public weak var delegate: BaseNotificationManagerDelegate?

    public init() {}

    public init(delegate: BaseNotificationManagerDelegate) { self.delegate = delegate }

    public func subscribe(to notification: BaseNotification, object: Any? = nil) {
        notificationCenter.addObserver(self, selector: #selector(selector), name: notification.name, object: object)
    }
    
    public func unsubscribe(from notification: BaseNotification, object: Any? = nil) {
        notificationCenter.removeObserver(self, name: notification.name, object: object)
    }
    
    public func trigger(notification: BaseNotification, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        notificationCenter.post(name: notification.name, object: object, userInfo: userInfo)
    }
    
    @objc private func selector(_ notification: Notification) {
        let baseNotification = BaseNotification(name: notification.name)
        delegate?.performOnTrigger(baseNotification, object: notification.object, userInfo: notification.userInfo)
    }
}
