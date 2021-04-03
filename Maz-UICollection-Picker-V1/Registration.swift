//
//  Registration.swift
//  Maz-UICollection-Picker-V1
//
//  Created by Shaik abdul mazeed on 01/03/21.
//

import UIKit
var saveMyData:[[String]]!
var saveUserData:[MyData] = []
class Registration: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var DOB: UITextField!
    
    @IBOutlet weak var profession: UITextField!
    
    var personProfessions:[String] = ["Actor", "Cricketer", "Politician"]
    var selectedImage:UIImage!
    //Creating instance to date picker class
    let datePicker = UIDatePicker()
    var picker:UIPickerView!
    var defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(tapGestureRecognizer:)))
        imageView.addGestureRecognizer(tapGesture)
        imageView.layer.cornerRadius = 70
        // Calling functions
        createDatePicker()
        createPickerView()
    }
    @objc func tapAction(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //openGallery()
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true, completion: nil)
    }
    //Creating a function for picker view
    func createPickerView()
    {
        //Creating picker for picking profession of the user
        picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        picker.delegate = self
        picker.dataSource = self
        profession.inputView = picker
    }
    //Creating a function for date picker component
    func createDatePicker()
    {
        
        //Creating an instance to the tool bar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Done button for tool bar
        let submit = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(submitPressed))
        toolBar.setItems([submit], animated: false)
        DOB.inputAccessoryView = toolBar
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = .orange
        DOB.inputView = datePicker
                
        //Formatting picker for date
        datePicker.datePickerMode = .date
        
    }
    @objc func submitPressed()
    {
        //Formatting date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        
        DOB.text = "\(dateString)"
        view.endEditing(true)
    }
    
    @IBAction func saveData(_ sender: Any) {
        //Condition to check minimum text count
        if(firstName.text!.count >= 3 && lastName.text!.count >= 3 && DOB.text!.count >= 2 && profession.text!.count >= 3 && imageView.image == selectedImage)
        {
            var retrievedImg = UIImage()
            if let imgData = defaults.object(forKey: "myImageKey") as? NSData {
                retrievedImg = UIImage(data: imgData as Data)!
            }
            
            let userData = MyData(myImage: retrievedImg, firstName: firstName.text!, LastName: lastName.text!, DOB: DOB.text!, profession: profession.text!)
            saveUserData.append(userData)
            
            //Calling alert function to create an alert
            
            let alert = UIAlertController(title: "Alert", message: "Saved Data Successfully", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.firstName.text = nil
                self.lastName.text = nil
                self.DOB.text = nil
                self.profession.text = nil
                self.imageView.image = UIImage(systemName: "person.fill")
                
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }else{
            //Calling alert function to create an alert
            alert(alerTitle: "Alert", message: "Please fill the details")
        }
        
    }
    //Creating a function to create alerts
    func alert(alerTitle:String, message:String)
    {
        let alert = UIAlertController(title: alerTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}
extension Registration: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        //Optional binding to uiimage
        if let img = info[.originalImage] as? UIImage{
            selectedImage = img
            imageView.image = selectedImage
            let data = img.pngData()
            self.defaults.set(data, forKey: "myImageKey")
            defaults.synchronize()
            
        }
        picker.dismiss(animated: true)
    }

}
extension Registration: UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return personProfessions.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        profession.text = personProfessions[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return personProfessions[row]
    }
    
    
}
