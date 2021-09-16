import Foundation

struct Genre {
    var sum: Int
    var songs: [Int : Int]
}

func solution(_ genres:[String], _ plays:[Int]) -> [Int] {
    var genreList = [String : Genre]()
    var answer = [Int]()
    
    for i in 0 ..< genres.count {
        let genre = genres[i], play = plays[i]

        if genreList[genre] == nil { genreList[genre] = Genre(sum: 0, songs: [:]) }
        genreList[genre]!.sum += play
        genreList[genre]!.songs[i] = play
    }

    let list = genreList.sorted { $0.value.sum > $1.value.sum }
    
    for l in list {
        let songs = l.value.songs.sorted { lhs, rhs in
            if lhs.value == rhs.value {
                return lhs.key < rhs.key
            }
            
            return lhs.value > rhs.value
        }
        
        var count = 1
        for song in songs {
            if count > 2 { break }
            
            answer.append(song.key)
            
            count += 1
        }
    }

    return answer
}

print(solution(["classic","classic","classic","classic","pop"], [500,150,800,800,2500]))
