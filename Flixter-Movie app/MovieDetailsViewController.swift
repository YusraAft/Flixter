//
//  MovieDetailsViewController.swift
//  Flixter-Movie app
//
//  Created by Mac User on 2/23/21.
//

import UIKit
import AlamofireImage //downloaded images form network -> library

class MovieDetailsViewController: UIViewController {
  
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: [String: Any]! //simply dictionary no array
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //print(movie["title"])
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)//like a string but enforces http etc.
        posterView.af_setImage(withURL: posterUrl!)
        let backdropPath = movie["poster_path"] as! String
        let backdropUrl = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)//like a string but enforces http etc.
        backdropView.af_setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
