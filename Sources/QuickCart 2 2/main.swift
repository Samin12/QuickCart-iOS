import Foundation
import Alamofire


let url = "https://api.twilio.com/2010-04-01/Accounts/ACf1cfc2cf9bab2c9e3939e6bfbf518f71/Messages"
  let parameters = ["From": "6468636486", "To": "3477612839", "Body": "cat"] as [String : Any]
  
  Alamofire.request(url, method: .post, parameters: parameters)
    .authenticate(user: "ACf1cfc2cf9bab2c9e3939e6bfbf518f71", password: "ec9e25df6028ab386bec76e96a5efc0d")
    .responseJSON { response in
        debugPrint(response)
  }

  RunLoop.main.run()
