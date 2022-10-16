//
//  NetworkService.swift
//  FileManager
//
//  Created by Alex M on 16.10.2022.
//

import Foundation
class NetworkService {

    var url: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    func getFiles () -> [URL] {
        let filesInDirectory = try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)

        let direction = UserDefaults.standard.bool(forKey: "SortingTypeKey")

        let files = filesInDirectory?.sorted(by: { url1, url2 in

            var isFolderUrl1: ObjCBool = false
            var isFolderUrl2: ObjCBool = false
            FileManager.default.fileExists(atPath: url1.path, isDirectory: &isFolderUrl1)
            FileManager.default.fileExists(atPath: url2.path, isDirectory: &isFolderUrl2)


            if direction {

                if isFolderUrl1.boolValue && isFolderUrl2.boolValue {
                    return url1.lastPathComponent < url2.lastPathComponent
                }
                if isFolderUrl1.boolValue && !isFolderUrl2.boolValue {
                    return true
                }
                if !isFolderUrl1.boolValue && isFolderUrl2.boolValue {
                    return false
                }

                return url1.lastPathComponent < url2.lastPathComponent
            } else {

                if isFolderUrl1.boolValue && isFolderUrl2.boolValue {
                    return url1.lastPathComponent > url2.lastPathComponent
                }
                if isFolderUrl1.boolValue && !isFolderUrl2.boolValue {
                    return false
                }
                if !isFolderUrl1.boolValue && isFolderUrl2.boolValue {
                    return true
                }

                return url1.lastPathComponent > url2.lastPathComponent

            }

        })

        return files ?? []
    }

}
