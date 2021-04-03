//
//  ViewController.swift
//  Maz-UICollection-Picker-V1
//
//  Created by Shaik abdul mazeed on 01/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySegment: UISegmentedControl!
    var tableView:UITableView!
    var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let table = tableView, let collection = collectionView{
            table.reloadData()
            collection.reloadData()
        }
        
        
    }
    
    @IBAction func registerUser(_ sender: UIButton) {
        
        let register = (storyboard?.instantiateViewController(identifier: "Registration"))! as Registration
        navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        if mySegment.selectedSegmentIndex == 0
        {
            
            if let collectionView = collectionView
            {
                collectionView.removeFromSuperview()
            }
            //tableView.reloadData()
            createTV()
        }else
        {
            if let tableView = tableView
            {
                tableView.removeFromSuperview()
               
            }
            collectionCV()
        }
    }
    func createTV()
    {
        tableView = UITableView(frame: CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.height), style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        let myCell = UINib(nibName: "MazTVCell", bundle: nil)
        tableView.register(myCell, forCellReuseIdentifier: "mazeedTV")
    }
    func collectionCV()
    {
        var collectionFLayout = UICollectionViewFlowLayout()
        collectionFLayout.itemSize = CGSize(width: view.frame.size.width / 2 - 5, height: 250)
        collectionFLayout.scrollDirection = .vertical
        collectionFLayout.minimumLineSpacing = 5
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: collectionFLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let CVCell = UINib(nibName: "MazCVCell", bundle: nil)
        collectionView.register(CVCell, forCellWithReuseIdentifier: "mazeedCV")
        view.addSubview(collectionView)
        
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return saveUserData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mazeedTV", for: indexPath) as! MazTVCell
        
        cell.TVImgV.image = saveUserData[indexPath.row].myImage
        cell.TVImgV.layer.cornerRadius = 80
        cell.firstName.text = "FirstName: \(saveUserData[indexPath.row].firstName)"
        cell.lastName.text = "LastName \(saveUserData[indexPath.row].LastName)"
        cell.DOB.text = "DOB: \(saveUserData[indexPath.row].DOB)"
        cell.profession.text = "Profession: \(saveUserData[indexPath.row].profession)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 213
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "DestinationVC") as! DestinationVC
        
        destination.destinationData = saveUserData[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
    
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveUserData.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mazeedCV", for: indexPath) as! MazCVCell

        
        cell.mazCV.image = saveUserData[indexPath.row].myImage
        cell.mazCV.layer.cornerRadius = 80
        
        cell.profession.text = saveUserData[indexPath.row].firstName
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = storyboard?.instantiateViewController(identifier: "DestinationVC") as! DestinationVC
        
        destination.destinationData = saveUserData[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    
}
