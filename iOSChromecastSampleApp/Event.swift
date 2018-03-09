//
//  Event.swift
//

import Foundation


public class Event<T> {
    public typealias EventHandler = (T) -> ()
    public var subscriptions = [Subscription<T>]()
    
    @discardableResult func subscribe(_ target: AnyObject, _ handler: @escaping EventHandler) -> Subscription<T> {
        let subscription = Subscription<T>(target: target, event: self, handler: handler)
        subscriptions.append(subscription)
        return subscription
    }
    
    func unsubscribe(_ target: AnyObject) {
        subscriptions = subscriptions.filter { $0.target !== target }
    }
    
    @discardableResult func subscribe(_ handler: @escaping EventHandler) -> Subscription<T> {
        let subscription = Subscription<T>(target: self, event: self, handler: handler)
        subscriptions.append(subscription)
        return subscription
    }
    
    func unsubscribe(_ subscription: Subscription<T>) {
        subscriptions = subscriptions.filter { $0 !== subscription }
    }
    
    func trigger(_ value: T) {
        subscriptions.forEach { (subscription) in
            subscription.handler(value)
        }
    }
    
    func dispose() {
        subscriptions = []
    }    
}


public class Subscription<T> {
    weak var target: AnyObject? = nil
    let event: Event<T>
    let handler: (T) -> ()
    
    init(target: AnyObject, event: Event<T>, handler: @escaping (T) -> ()) {
        self.target = target
        self.event = event
        self.handler = handler
    }
    
    func dispose() {
        event.unsubscribe(self)
    }
}
