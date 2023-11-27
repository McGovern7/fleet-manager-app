import SwiftUI
import CoreNFC

@available(iOS 13.0, *)
public class MiFareReader: NSObject, ObservableObject, NFCTagReaderSessionDelegate{
    @Published var message: String = ""
    public var session: NFCTagReaderSession?
    
    public func read(){
        guard NFCTagReaderSession.readingAvailable else{
            print("Error")
            return
        }
        
        session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self, queue: nil)
        session?.alertMessage = "Scan a tag"
        session?.begin()
    }
    
    public func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        return
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        DispatchQueue.main.async{
            for tag in tags{
                if case let .miFare(mifareTag) = tag {
                    self.message = "\(mifareTag.identifier.base64EncodedString())"
                }
            }
        }
        session.alertMessage = "Found a tag!"
        session.invalidate()
        return
    }
    
    public func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print(error)
        return
    }
}
