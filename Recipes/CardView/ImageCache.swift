//
//  ImageCache.swift
//  Recipes
//
//  Created by Amey Kanunje on 12/4/24.
//

import Foundation

actor ImageCache<Key:Hashable, Value>{
    var cache: [Key : Value] = [:]
    
    func setObject(_ object: Value, forKey key: Key){
        cache[key] = object
    }
    
    func retriveObject(forKey key: Key)-> Value?{
        return cache[key]
    }
    
    func clearData(){
        cache.removeAll()
    }
}
