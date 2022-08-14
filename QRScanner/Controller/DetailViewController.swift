//
//  DetailViewController.swift
//  QRScanner
//


import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var enginSizeLabel: UILabel!
    @IBOutlet weak var emissionLabel: UILabel!
    @IBOutlet weak var perDayLabel: UILabel!
    @IBOutlet weak var perMonthLabel: UILabel!
    @IBOutlet weak var perYearLabel: UILabel!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    
    
    //MARK :- variable
    var qrData: QRData?
    
    
    //MARK :- View Life cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        getVehicleImage()
        getDisplayData()
    }
    
    func getVehicleImage(){
        if let dict = convertRawStringToJson(), let imageUrl = dict["image"] as? String {
            imageView.image = UIImage(url: URL(string: imageUrl))
        }
    }
    
    func getDisplayData() {
        let dict = convertRawStringToJson()
        makeLabel.text = dict?["make"] as? String
        modelLabel.text = dict?["model"] as? String
        enginSizeLabel.text = String(dict?["engine_size"] as? Double ?? 0.0)
        emissionLabel.text = String(dict?["emissions"] as? Int ?? 0)
        fuelTypeLabel.text = dict?["fuel"] as? String == "P" ? "Petrol" : "Diesel"
        let value = dict?["emissions"] as? Int ?? 0
        let perDay = (55.0 * Double(value)) / 1000.0
        perDayLabel.text = String(format: "%0.2f", perDay)
        perMonthLabel.text = String(format: "%0.2f", perDay * 30)
        let overTheYear = String(format: "%0.2f", perDay * 365)
        perYearLabel.text = overTheYear
        noteLabel.text = String(format: "It takes %d fully grown trees in ideal conditions to purify %@ Kg of CO2 from the environment over a year.", Int((((Double(overTheYear) ?? 0) / 25).rounded())), overTheYear)
    }
    
    func convertRawStringToJson()-> [String: Any]? {
        let dict = qrData?.codeString?.convertToDictionary() ?? [:]
        return dict
    }
    
}

