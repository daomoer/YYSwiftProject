//
//  FMRecommendAPI.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import SVProgressHUD

/// 首页推荐主接口
let FMRecommendProvider = MoyaProvider<FMRecommendAPI>()

enum FMRecommendAPI {
    case recommendList//推荐列表
}

extension FMRecommendAPI: TargetType {

    var baseURL: URL { return URL(string: "http://mobile.ximalaya.com")! }

    var path: String {
        switch self {
        case .recommendList: return "/discovery-firstpage/v2/explore/ts-1532411485052"
        }
    }

    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters = [
            "appid":0,
            "categoryId":-2,
            "channel":"ios-b1",
            "code":"43_310000_3100",
            "includeActivity":true,
            "includeSpecial":true,
            "network":"WIFI",
            "operator":3,
            "pullToRefresh":true,
            "scale":3,
            "uid":0,
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        switch self {

        case .recommendList:
            parmeters["device"] = "iPhone"
        }

        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

