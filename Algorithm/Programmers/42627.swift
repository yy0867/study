import Foundation

func solution(_ jobs:[[Int]]) -> Int {
    let come = 0 // jobs[n][come]
    let take = 1 // jobs[n][take]
    var result = 0
    var sortedJobs = jobs.sorted(by: { $0[take] < $1[take] })
    let totalTime = jobs.reduce(0) { $0 + $1[take] }
    var t = 0
    
    while t <= totalTime {
        let possibleJobs = sortedJobs.filter { $0[come] <= t }.sorted { $0[take] < $1[take] }
        if possibleJobs.isEmpty { t += 1; continue }
        let curJob = possibleJobs.first!
        t += curJob[take]
        result += (t - curJob[come])
        sortedJobs.remove(at: sortedJobs.firstIndex(of: curJob)!)
    }
    
    return result / jobs.count
}

print(solution([[0, 3], [1, 9], [2, 6]]))