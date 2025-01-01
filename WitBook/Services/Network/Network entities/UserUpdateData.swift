//
//  UserUpdateData.swift
//  WitBook
//
//  Created by rbkusser on 31.12.2024.
//

import Foundation

struct UserUpdateData: Encodable {
    
    var username: String?
    var avatar: Data?
    
    var fields: [String: String] {
        var dict: [String: String] = [:]
        if let username {
            dict["username"] = username
        }
        
        return dict
    }

      func toMultipartData() -> MultipartData {
          var files: [MultipartFile] = []
        
          if let avatarData = avatar {
              let avatarFile = MultipartFile(
                  key: "avatar",
                  filename: "avatar.jpg",
                  data: avatarData,
                  mimeType: "image/jpeg"
              )
              files.append(avatarFile)
          }
          
          return MultipartData(fields: fields, files: files)
      }
}
