import Foundation

struct MovieModel: Hashable {
    let title: String
    let year: Int
    
    init() {
        title = ""
        year = 0
    }
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}

