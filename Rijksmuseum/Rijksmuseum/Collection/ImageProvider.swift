//
//  ImageProvider.swift
//  Rijksmuseum
//
//  Created by Troian on 31.05.2023.
//

import Foundation
import UIKit

protocol ImageProviding {
    
}

class ImageProvider: ImageProviding {
    
}


import UIKit
public protocol DataStorage {
    func save(_ object: Codable, for key: String)
    func load<T>(for key: String, type: T.Type) -> T? where T: Codable
    func remove(for key: String)
}

public struct Storage: DataStorage {
    public init() {}
    
    public func save(_ object: Codable, for key: String) {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(key).json")
            try JSONEncoder()
                .encode(object)
                .write(to: fileURL)
        } catch {
            print("error writing data")
        }
    }
    
    public func load<T>(for key: String, type: T.Type) -> T? where T: Codable {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(key).json")
            let data = try Data(contentsOf: fileURL)
            let anyCodable = try JSONDecoder().decode(type.self, from: data)
            return anyCodable
        } catch {
            print("error reading data")
            return nil
        }
    }
    
    public func remove(for key: String) {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(key).json")
            try FileManager.default.removeItem(atPath: fileURL.absoluteString)
        } catch {
            print("error writing data")
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

public protocol ImageStorage {
    func save(_ object: UIImage, for key: String)
    func loadImage(for key: String) -> UIImage?
}

extension Storage: ImageStorage {
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
}


public class ImageLoader {
    public static let shared = ImageLoader()
    private let storage: ImageStorage
    
    
    
    public init(storage: ImageStorage = Storage()) {
        self.storage = storage
    }
    
    public final func load(url: String) async throws -> UIImage? {

        if let image = storage.loadImage(for: url) {
            return image
        } else {
            guard let imageURL = URL(string: url) else { throw NSError(domain: "InvalidImage", code: 0, userInfo: nil) }

            let (data, _) = try await URLSession.shared.data(from: imageURL)
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "InvalidImage", code: 0, userInfo: nil)
            }
            storage.save(image, for: url)
            return image
        }
    }
}
