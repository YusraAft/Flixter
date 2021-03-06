//
//  MoviesViewController.swift
//  Flixter-Movie app
//
//  Created by Mac User on 2/16/21.
//

import UIKit
import AlamofireImage
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    //properties varaibles
    var movies = [[String: Any]]() //array of dictionaries
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              self.movies = dataDictionary["results"] as! [[String: Any]] //now download is complete
              self.tableView.reloadData() //call the below functions again
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
//github
           }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count //20 because 20 items in dictionary from API
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell//deque stuff because possible to have 100 cells
        //so that would be too much so using recycled cells from offscreen cells.
        //as! is casting and we are saying we want to access it like a MovieCell which is a classwe made in another file using coclass.
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String //title is a string
        let synopsis = movie["overview"] as! String // overview is th ekey; found using json extension after api run
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = synopsis //configuiting text to say what synopisis is
        
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)!//like a string but enforces http etc.
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    //find the selected movie
//    //the sender is the celll that was tapped on
        //tableview what is the indexpath for that cell?
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for: cell)!
    let movie = movies[indexPath.row]
    //pass he selected movie to the detailsmoviecontroller
    let detailsViewController = segue.destination as! MovieDetailsViewController
        //cast because it would otherwise give a gneric controller
    detailsViewController.movie = movie //referring to movie on line 82
        tableView.deselectRow(at: indexPath, animated: true) //no longer highlighted the tapped cell
        
    }
}
