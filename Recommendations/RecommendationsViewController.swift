//
//  ViewController.swift
//  Recommendations
//

import UIKit
import OHHTTPStubs

struct Recommendation {
    var imageURL = String()
    var title = String()
    var tagline = String()
    var rating: Float = 0.0
    var isReleased: Bool = false
}

class RecommendationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recommendations = [Recommendation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------------------------------------------------
        // -------- <DO NOT MODIFY INSIDE THIS BLOCK> --------
        // stub the network response with our local ratings.json file
        let stub = Stub()
        stub.registerStub()
        // -------- </DO NOT MODIFY INSIDE THIS BLOCK> -------
        // ---------------------------------------------------
        
        tableView.register(UINib(nibName: "RecommendationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        // NOTE: please maintain the stubbed url we use here and the usage of
        // a URLSession dataTask to ensure our stubbed response continues to
        // work; however, feel free to reorganize/rewrite/refactor as needed
        guard let url = URL(string: Stub.stubbedURL_doNotChange) else { fatalError() }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let receivedData = data else { return }
            
            // TASK: This feels gross and smells. Can this json parsing be made more robust and extensible?
            do {
                let json = try JSONSerialization.jsonObject(with: receivedData, options: JSONSerialization.ReadingOptions(rawValue: UInt(0))) as! [String: AnyObject]
                
                if let titles = json["titles"] as? [[String: AnyObject]] {
                    for title in titles {
                        var recommendation = Recommendation()
                        
                        if let name = title["title"] as? String {
                            recommendation.title = name
                        }
                        
                        if let isReleased = title["is_released"] as? Bool {
                            recommendation.isReleased = isReleased
                        }
                        
                        if let ratingObj = title["rating"],
                            let rating = Float("\(ratingObj)") {
                            recommendation.rating = rating
                        }
                        
                        if let tagline = title["tagline"] as? String {
                            recommendation.tagline = tagline
                        }
                        
                        if let image = title["image"] as? String {
                            recommendation.imageURL = image
                        }

                        self.recommendations.append(recommendation)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch {
                fatalError("Error parsing stubbed json data: \(error)")
            }
        });

        task.resume()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecommendationTableViewCell
        
        let recommendation = recommendations[indexPath.row]

        cell.titleLabel.text = recommendation.title
        cell.taglineLabel.text = recommendation.tagline
        cell.ratingLabel.text = "Rating: \(recommendation.rating)"
        
        if let url = URL(string: recommendation.imageURL) {
            let data = try? Data(contentsOf: url)

            if let imageData = data {
                let image = UIImage(data: imageData)
                cell.recommendationImageView?.image = image
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommendations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
}
