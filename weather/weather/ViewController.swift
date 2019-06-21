//
//  ViewController.swift
//  weather
//
//  Created by WSR on 6/20/19.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var city = ""
    var temp = "0"
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var icoWeather: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let userDefaults = UserDefaults()
        city = userDefaults.string(forKey: "lastCity") ?? "Москва"
        cityName.text = city
        
        //запрашиваем температуру для текущего города
        downloadData(city: city)
        
        randomBackground(city: city)
    }

    func randomBackground(city: String){
        let token = "fe96c1b0698cf5d73c48e7e14623f5f9"
        let translitCity = city.applyingTransform(.latinToCyrillic, reverse: true)
        let url = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(token)&user_id=&tags=\(city)&per_page=10&page=1&format=json&nojsoncallback=1"
        let photoListUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
        //print(photoListUrl!)
            
        Alamofire.request(photoListUrl!, method: .get).validate().responseJSON { response in
            switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //print(json)
                    let photoItem = json["photos"]["photo"][0]
                    print(photoItem)
//                        //let farm = json?["photos"]?["photo"]?[0]?["farm"] as? String
//                        //if photoList.count>0{
//                        let photoUrl = "https://farm\(farm).staticflickr.com/\(photoItem["server"].stringValue)/\(photoItem["id"].stringValue)_\(photoItem["secret"].stringValue).jpg"
//
//                        if let url = URL(string: photoUrl){
//                            if let data = try? Data(contentsOf: url){
//                                self.background.image = UIImage(data: data)
//                            }
//                        }
//
                    
                        //}
                    case .failure(let error):
                        print(error)
                }
            //}

        }
        
    }
    
    func downloadData(city: String) {
        // токен для АПИ
        let token = "1e936ee21707e2a418e98dca00877357"
        
        // УРЛ с городом, метрической системой и токеном
        let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(token)"
        
        // перекодируем адрес (URLencode)
        let url = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        // посылаем запрос
        Alamofire.request(url!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                //если запрос выполнен успешно, то разбираем ответ и вытаскиваем нужные данные
                let json = JSON(value)
                //print(json)
                self.temp = json["main"]["temp"].stringValue
                self.lblTemp.text = json["main"]["temp"].stringValue+"°C"
                
                let icoName = json["weather"][0]["icon"].stringValue
                
                if let urlStr2 = URL(string: "https://openweathermap.org/img/w/\(icoName).png") {
                    //if let qq =
                    if let data = try? Data(contentsOf: urlStr2){
                        self.icoWeather.image = UIImage(data: data)
                        
                    }

                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

