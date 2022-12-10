
import Foundation


struct UserFromJSON {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}


var userArray: [UserFromJSON] = []

struct PlanetInstance: Codable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String
}


var orbitalPeriod: String = ""
