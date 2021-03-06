//
//  OperationObserver.swift
//  Operations
//
//  Created by Daniel Thorpe on 26/06/2015.
//  Copyright (c) 2015 Daniel Thorpe. All rights reserved.
//

import Foundation

public enum OperationEvent: Int {
    case Attached = 0, Started, Cancelled, Produced, Finished
}

extension OperationEvent: CustomStringConvertible {
    public var description: String {
        switch self {
        case .Attached: return "Attached"
        case .Started: return "Started"
        case .Cancelled: return "Cancelled"
        case .Produced: return "Produced"
        case .Finished: return "Finished"
        }
    }
}

/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue.
 */
public protocol OperationObserverType {

    /**
     Observer gets notified when it is attached to an operation.

     - parameter operation: the observed `Operation`.
    */
    func didAttachToOperation(operation: AdvancedOperation)
}



public extension OperationObserverType {

    /**
     Default implementation of didAttachToOperation
     is a none-operation.

     - parameter operation: the observed `Operation`.
    */
    func didAttachToOperation(operation: AdvancedOperation) { /* No operation */ }
}



/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive a callback when the operation starts.
 */
public protocol OperationWillExecuteObserver: OperationObserverType {

    /**
     The operation will execute.

     - parameter operation: the observed `Operation`.
     */
    func willExecuteOperation(operation: AdvancedOperation)
}


/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive a callback when the operation cancels.
 */
public protocol OperationWillCancelObserver: OperationObserverType {

    /**
     The operation will cancel.

     - parameter operation: the observed `Operation`.
     */
    func willCancelOperation(operation: AdvancedOperation, errors: [ErrorType])
}


/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive a callback when the operation cancels.
 */
public protocol OperationDidCancelObserver: OperationObserverType {

    /**
     The operation did cancel.

     - parameter operation: the observed `Operation`.
     */
    func didCancelOperation(operation: AdvancedOperation)
}


/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive a callback when the operation produces
 another operation.
 */
public protocol OperationDidProduceOperationObserver: OperationObserverType {

    /**
     The operation produced a new `NSOperation` instance which has been added to the
     queue. Note that this isn't necessarily an `Operation`, so be careful, if you
     intend to automatically start observing it.

     - parameter operation: the observed `Operation`.
     - parameter newOperation: the produced `NSOperation`
     */
    func operation(operation: AdvancedOperation, didProduceOperation newOperation: NSOperation)
}


/**
 Types which confirm to this protocol, can be attached to `Operation` subclasses.
 */
public protocol OperationWillFinishObserver: OperationObserverType {

    /**
     The operation will finish. Any errors that were encountered are collected here.

     - parameter operation: the observed `Operation`.
     - parameter errors: an array of `ErrorType`s.
     */
    func willFinishOperation(operation: AdvancedOperation, errors: [ErrorType])
}


/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive a callback when the operation finishes.
 */
public protocol OperationDidFinishObserver: OperationObserverType {

    /**
     The operation did finish. Any errors that were encountered are collected here.

     - parameter operation: the observed `Operation`.
     - parameter errors: an array of `ErrorType`s.
     */
    func didFinishOperation(operation: AdvancedOperation, errors: [ErrorType])
}


/**
 Types which conform to this protocol, can be attached to `Operation` subclasses before
 they are added to a queue. They will receive callbacks when the operation starts,
 produces a new operation, and finishes.
 */
public protocol OperationObserver: OperationWillExecuteObserver, OperationWillCancelObserver, OperationDidCancelObserver, OperationDidProduceOperationObserver, OperationWillFinishObserver, OperationDidFinishObserver { }
