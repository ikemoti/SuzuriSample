//
//  ViewController.swift
//  SuzuriSample
//
//  Created by Sousuke Ikemoto on 2020/12/17.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = .red
        putOmoide()
        getOmoide()
    }
    
    
    func registerUser(idtoken: String ) {
        let apikey = "sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        let test: HTTPHeaders? = ["Authorization": "Bearer \(apikey)"]
//        let header: HTTPHeaders? = ["Authorization": "Bearer 1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcd"]
        let url = "https://suzuri.jp/api/v1/activities"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: test ).responseJSON { response  in
            print("テス")
            guard let data = response.data else { return print("return") }
//            let user = try! JSONDecoder().decode(UserModel.self, from: data)
            print("response: \(response)")
            print("data: \(data)")
            print("イエー")
//            print("user: \(String(describing: user))")
        }
    }
    
    func getOmoide(){
        let apikey = "sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        let test: HTTPHeaders? = ["Authorization": "Bearer \(apikey)"]
        let url = "https://suzuri.jp/api/v1/choices"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: test ).responseJSON { response  in
            print("テス")
            guard let data = response.data else { return print("return") }
//            let user = try! JSONDecoder().decode(UserModel.self, from: data)
            print("response: \(response)")
            print("data: \(data)")
            print("イエー")
//            print("user: \(String(describing: user))")
        }
    }
    func putOmoide(){
        let apikey = "sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        let test: HTTPHeaders? = ["Authorization": "Bearer \(apikey)"]
        let url = "https://suzuri.jp/api/v1/choices"
        let parameter  = ["title": "do-mo!!!"]
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: test ).responseJSON { response  in
            print("テス")
            guard let data = response.data else { return print("return") }
//            let user = try! JSONDecoder().decode(UserModel.self, from: data)
            print("response: \(response)")
            print("data: \(data)")
            print("イエー")
//            print("user: \(String(describing: user))")
        }
    }
    
    
    

}

