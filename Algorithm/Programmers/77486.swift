import Foundation

func solution(_ enroll:[String], _ referral:[String], _ seller:[String], _ amount:[Int]) -> [Int] {
    var referralOf = [String : String]()
    var indexOf = [String : Int]()
    var earnOf = [String : Int]()
    
    for i in 0 ..< enroll.count {
        indexOf.updateValue(i, forKey: enroll[i])
        referralOf.updateValue(referral[i], forKey: enroll[i])
        earnOf.updateValue(0, forKey: enroll[i])
    }
    
    for i in 0 ..< seller.count {
        var price = amount[i] * 100
        var curSeller = seller[i]
        
        while curSeller != "-" {
            let referralPrice = price / 10
            let sellerPrice = price - referralPrice
            
            earnOf[curSeller]! += sellerPrice
            
            curSeller = referralOf[curSeller]!
            price = referralPrice
        }
    }
    
    return indexOf.sorted {$0.value < $1.value }.map { earnOf[$0.key]! }
}

print(solution(
    ["john", "mary", "edward", "sam", "emily", "jaimie", "tod", "young"],
    ["-", "-", "mary", "edward", "mary", "mary", "jaimie", "edward"],
    ["young", "john", "tod", "emily", "mary"],
    [12, 4, 2, 5, 10])
)