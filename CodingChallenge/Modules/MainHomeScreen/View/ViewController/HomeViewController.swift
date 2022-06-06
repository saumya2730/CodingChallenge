//
//  HomeViewController.swift
//  CodingChallenge
//
//  Created by 01HW1928584 on 05/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var lblNASA: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblExplanation: UILabel!
    @IBOutlet weak var textFieldDate: UITextField!
    @IBOutlet weak var btnAddToFav: UIButton!
    
    // MARK: - Variables
    let datePicker = UIDatePicker()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    private var apiServiceModel = ApiHomeViewModel()
    var isActive: Bool = false
    var images = [AnyObject]()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()
        getApod(date: Date())
    }
    
    // MARK: - IBAction
    @IBAction func btnAddToFav(_ sender: Any) {
        if isActive {
            apiServiceModel.removeFromFav()
            isActive = false
            btnAddToFav.setImage(UIImage(named: "FavUnselected"), for: .normal)
            print("Removed from Favorites")
        } else {
            apiServiceModel.addingToFav()
            isActive = true
            btnAddToFav.setImage(UIImage(named: "FavSelected"), for: .normal)
            print("Added to Favorites")
        }
    }
    
    // MARK: - Objective C Functions
    @objc func dateChange(datePicker: UIDatePicker) {
        textFieldDate.resignFirstResponder()
        textFieldDate.text = formatDate(date: datePicker.date)
        self.view.endEditing(true)
        getApod(date: datePicker.date)
    }
    
    @objc func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    // MARK: - Methods
    func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        
        textFieldDate.inputView = datePicker
        textFieldDate.text = formatDate(date: Date())
    }
    
    func getApod(date:Date) {
        activityIndicator.startAnimating()
        apiServiceModel.callApodApi(queryDate: date) { (isSuccess,error) in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.activityIndicator.stopAnimating()
                if(isSuccess) {
                    self.updateUIData()
                }else {
                    self.showAlert(error: error)
                }
            }
        }
    }
    
    
    //Update UI Data
    func updateUIData() {
        
        btnAddToFav.setImage(apiServiceModel.getFavSelectionStatus() ? UIImage(named: "FavSelected"): UIImage(named: "FavUnselected") , for: .normal)
        isActive = apiServiceModel.getFavSelectionStatus()
        
        lblTitle.text = apiServiceModel.title
        lblExplanation.text = apiServiceModel.explanation
        textFieldDate.text = apiServiceModel.date
        lblDate.text = apiServiceModel.date
        if (apiServiceModel.media_type == GlobalConstants.MediaType.image) {
            imageView.loadImage(withUrl: apiServiceModel.url ?? "")
        }else {
            imageView.image = UIImage(named: GlobalConstants.NoImage)
            //Or Code for Play Video if have direct video URL
        }
    }
    //Show Error Alert
    func showAlert(error: String?) {
        
        let alert = UIAlertController(title: GlobalConstants.ErrorAlertTitle, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: GlobalConstants.OkAlertTitle, style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
    
    
}
