//
//  RestaurantTableView.swift
//  restaurantGuide
//
//  Created by Laptop on 2021-04-14.
//

import UIKit
class RestaurantTableView: UITableViewController
{
    var restaurantList = [Restaurant]()
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "retaurantCellID") as! RestaurantCell
        
        let thisRestaurant: Restaurant!
        thisRestaurant = restaurantList[indexPath.row]
        
        restaurantCell.titleLabel.text = thisRestaurant.title
        restaurantCell.descLabel.text = thisRestaurant.desc
        
        return restaurantCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList
    }
}
