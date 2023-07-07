//
//  NetworkResult.swift
//  MuslingProject
//
//  Created by 이나경 on 2023/07/07.
//

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
