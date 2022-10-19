
import Foundation

protocol NetworkServiceProtocol {
    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}


enum AppConfiguration: String {
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
    case baseHomeWokr2task1 = "https://jsonplaceholder.typicode.com/todos/"
}



final class NetworkService {

    private let mainQueue = DispatchQueue.main
}

extension NetworkService: NetworkServiceProtocol {

    func request(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }

            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }

            self.mainQueue.async { completion(.success(data)) }
        })

        task.resume()
    }
}






//
//class NetworkService {
//
//
//    static func request(for configuration: AppConfiguration) {
//
//        let strURL = configuration.rawValue
//
//        if let url = URL(string: strURL) {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data {
//                    print ("✅ \(data)")
//                }
//                print ("➡️ \(response)")
//                print ("❌ \(error)")
//            }
//
//            task.resume()
//        }
//
//    }
//
//}
