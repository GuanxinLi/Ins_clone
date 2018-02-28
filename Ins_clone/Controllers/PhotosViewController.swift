//
//  PhotosViewController.swift
//  Ins_clone
//
//  Created by Guanxin Li on 2/26/18.
//  Copyright © 2018 Guanxin. All rights reserved.
//

import UIKit
import Parse

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post]? = []
    var refresh: UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(PhotosViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refresh, at: 0)
        self.update()

   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let post = self.posts?[indexPath.row]
        if post != nil {
            cell.insPost = post
        }
        return cell
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.update()
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        update()
    }
    
    func update(){
        let query = PFQuery(className: "Post")
        query.includeKey("author")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        query.findObjectsInBackground{ (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts as? [Post]
                self.tableView.reloadData()
                self.refresh.endRefreshing()
            } else {
                print("Cannot reload: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = posts![indexPath.row]
            let detailViewController = segue.destination as! DetailedViewController
            detailViewController.post = post
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
