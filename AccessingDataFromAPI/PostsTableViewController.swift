//
//  PostsTableViewController.swift
//  AccessingDataFromAPI
//
//  Created by Palliboina on 05/05/24.
//

import UIKit

class PostsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        prepareDatasource()
        
        Task(priority:.high){
            await loadPostsFromAPI()
        }
        
    }
    
    func loadPostsFromAPI() async {
        let session = URLSession.shared
        let webUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
        do{
            let (data,response) = try await session.data(from: webUrl!)
            if let res = response as? HTTPURLResponse {
                let statusCode = res.statusCode
                if statusCode == 200 {
                    let decoder = JSONDecoder()
                    let posts = try? decoder.decode([Post].self, from: data)
                    postsData.listPosts = posts ?? []
                    
                    await MainActor.run{
                        self.prepareSnapshot()
                    }
                    
                }else{
                    print("Error: \(statusCode)")
                }
            }
        }catch{
            print("Error:\(error)")
        }
    }

    func prepareDatasource(){
        postsData.datasource = UITableViewDiffableDataSource<Sections,Post.ID>(tableView: tableView, cellProvider: {tableView,indexPath,itemId in
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell",for: indexPath)
            
            if let item = postsData.listPosts.first(where: {$0.id == itemId}) {
                var config = cell.defaultContentConfiguration()
                config.text = item.title
                config.secondaryText = item.body
                cell.contentConfiguration = config
            }
            
            return cell
        })
    }
    
    func prepareSnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections,Post.ID>()
        snapshot.appendSections([.main])
        snapshot.appendItems(postsData.listPosts.map({$0.id}))
        postsData.datasource.apply(snapshot)
    }
}
