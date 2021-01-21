

import Foundation

public struct IDCardScannerError: LocalizedError {
    public enum Kind { case cameraSetup, photoProcessing, authorizationDenied, capture }
    public var kind: Kind
    public var underlyingError: Error?
    public var errorDescription: String? { (underlyingError as? LocalizedError)?.errorDescription }
}
