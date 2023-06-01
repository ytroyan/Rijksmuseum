import Foundation
import UIKit

public protocol ImageStoraging {
    func save(_ object: UIImage, for key: String)
    func loadImage(for key: String) -> UIImage?
}

public struct ImageStorage: ImageStoraging {
    public init() {}
    
    public func save(_ object: UIImage, for key: String) {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(key).jpg")
            print(fileURL)
            if let data = object.jpegData(compressionQuality: 1) {
                try data.write(to: fileURL)
            }
        } catch {
            print("error writing data \(error)")
        }
    }
    
    public func loadImage(for key: String) -> UIImage? {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(key).jpg")
            print("load", fileURL)
            let data = try Data(contentsOf: fileURL)
            let image = UIImage(data: data)
            return image
        } catch {
            print("error reading data \(error)")
            return nil
        }
    }
    
    public func removeAll() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                print("file \(fileURL)")
                try FileManager.default.removeItem(at: fileURL)
            }
        } catch  { print(error) }
    }
}

