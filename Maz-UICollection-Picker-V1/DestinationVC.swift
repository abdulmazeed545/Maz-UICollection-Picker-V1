//
//  DestinationVC.swift
//  Maz-UICollection-Picker-V1
//
//  Created by Shaik abdul mazeed on 01/03/21.
//

import UIKit

class DestinationVC: UIViewController {
    
    //Creating global variables
    var destinationData:MyData!
       
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var DOB: UILabel!
    @IBOutlet weak var profession: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        personImage.image = destinationData.myImage
        personImage.layer.cornerRadius = 150
        firstName.text = "First Name: \(destinationData.firstName)"
        lastName.text = "Last Name: \(destinationData.LastName)"
        DOB.text = "DOB: \(destinationData.DOB)"
        profession.text = "Profession: \(destinationData.profession)"
        //Calling function
        label(label:firstName)
        label(label:lastName)
        label(label:DOB)
        label(label:profession)
        // Do any additional setup after loading the view.
    }
    //Creating function for uilabel
    func label(label:UILabel){
        label.textColor = .darkText
        label.font = UIFont(name: "Arial Bold", size: 20)
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
