//
//  LocalStorege.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import Foundation
import ObjectMapper

open class LocalStorege: NSObject {

    override init() {}

    open func addFavoriteChar(id:Int) throws {
        var list:[Int] = []
        if (App.keychain.get("favoriteList") != nil) {
            list = arrayFromString(App.keychain.get("favoriteList") ?? "") ?? []
            list.append(id)
        }else {
            list.append(id)
        }
        try App.keychain.save("favoriteList", value: stringFromArray(list) ?? "")
    }
    
    open func removeFavoriteChar(id:Int) throws {
        var list:[Int] = []
        if (App.keychain.get("favoriteList") != nil) {
            list = arrayFromString(App.keychain.get("favoriteList") ?? "") ?? []
            list.remove(at: list.firstIndex(of: id) ?? 0)
        }
        try App.keychain.save("favoriteList", value: stringFromArray(list) ?? "")

    }
    
    open func getFavoriteList() -> [Int] {
        return arrayFromString(App.keychain.get("favoriteList") ?? "") ?? []
    }
    
    
    open func removeFavoriteList() {
        App.keychain.remove("favoriteList")
    }
    
    func stringFromArray(_ array: [Int]) -> String? {
        return (try? JSONSerialization.data(withJSONObject: array, options: []))?.base64EncodedString()
    }
    func arrayFromString(_ string: String) -> [Int]? {
        guard let data = Data(base64Encoded: string) else {
            return nil
        }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [Int]
    }
}
