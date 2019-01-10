//
//  ViewController.swift
//  MoyaDemo
//
//  Created by liulichao on 2019/1/10.
//  Copyright © 2019 liulichao. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let provider = MoyaProvider<HttpRequest>()
        provider.request(.demo1) { result in
            result.
        }

    }


}

enum HttpRequest: TargetType {
    case demo1
    case demo2(name: String)
    case demo3(name: String, store: Int)
    
    var baseURL: URL {
        return URL.init(string: "http://baidu.com")!
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data.init()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var path: String {
        return "aaa"
    }
    
    
}

