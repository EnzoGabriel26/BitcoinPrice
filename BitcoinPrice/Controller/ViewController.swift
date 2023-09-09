//  ViewController.swift


import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }
}
//MARK: - UIPickerDataSource
extension ViewController: UIPickerViewDataSource{
    //essa funcao escolhe o numero de colunas
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //essa funcao escolhe o numero de linhas
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}
//MARK: - UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate{
    //essa funcao faz trocar os titulos do picker view
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    //mostra o que esta selecionado
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let chosenCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: String(chosenCurrency))
    }
    
    //
}
//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCoin(_ CoinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.sync{
            currencyLabel.text = coin.currency
            bitcoinLabel.text = coin.coinValueString
            print(coin.coinValue)
            print(coin.coinName)
            print(coin.currency)
        }
    }
}

