import UIKit
import AVFoundation
import PlaygroundSupport

public class DescriptionBoard: UIViewController {
    
    public var frameSize: CGRect!
    public var wallpapersImageNames = [String]()
    public var currentRandomWallpaper = ""
    
    public var mainBG: UIImageView!
    public var blurredView: UIView!
    public var logoImageView: UIImageView!
    public var player: AVAudioPlayer?

    var nextButton: UIButton!
    var descriptionText: UILabel!
    var descriptionImageView: UIImageView!
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        mainBG = UIImageView(frame: frameSize!)
        mainBG.image = UIImage(named: currentRandomWallpaper)
        mainBG.contentMode = .scaleAspectFill
        view.addSubview(mainBG)
        
        blurredView = UIView(frame: frameSize)
        blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        view.addSubview(blurredView)
        
        logoImageView = UIImageView(frame: CGRect(x: 150, y: 40, width: 300, height: 70))
        logoImageView.image = UIImage(named: "Bookonesia3x")
        logoImageView.clipsToBounds = true
        view.addSubview(logoImageView)
        
        Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        descriptionImageView = UIImageView(frame: CGRect(x: 125, y: 120, width: 350, height: 40))
        descriptionImageView.image = UIImage(named: "description")
        descriptionImageView.contentMode = .scaleAspectFit
        view.addSubview(descriptionImageView)
        
        nextButton = UIButton(type: UIButton.ButtonType.system)
        nextButton.frame = CGRect(x: 150, y: 670, width: 300, height: 70)
        nextButton.backgroundColor = UIColor(red: 87/255, green: 154/255, blue: 9/255, alpha: 1)
        nextButton.tintColor = .white
        nextButton.setTitle("Next", for: .normal)
        nextButton.layer.cornerRadius = 5
        nextButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 25)
        view.addSubview(nextButton)
        
        descriptionText = UILabel(frame: CGRect(x: 50, y: 150, width: 500, height: 400))
        descriptionText.text = "• Bookonesia consists of two words, ‘book' and 'Indonesia'. The word 'Bookonesia' is read like ‘Bukunesia' in Bahasa Indonesia, which stands for 'buku' (book) and 'Indonesia'. \n\n• The idea of this playgrond project is to introduce various Indonesian cultures in a simple and easy way that act like a digital book. There are tourist attractions, musics, foods and animals which are typical of Indonesia.\n\n• This project also comes with supporting images and informations. Also comes with backsound which has characteristic of Indonesian traditional music. All supporting files used in this playground are free and with attribution.\n\n• Curious? Let’s get started!"
        descriptionText.numberOfLines = 0
        descriptionText.textColor = .white
        view.addSubview(descriptionText)
        descriptionText.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.descriptionText.alpha = 1
            self.descriptionText.layoutIfNeeded()
        }
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    func wallpaperRandomUtility() -> String {
        let random = wallpapersImageNames.randomElement()
        if random == currentRandomWallpaper {
        } else {
            currentRandomWallpaper = random!
        }
        return currentRandomWallpaper
    }
    
    @objc
    func nextButtonTapped(){
        let listBoard = ListBoard()
        listBoard.currentRandomWallpaper = self.currentRandomWallpaper
        listBoard.wallpapersImageNames = self.wallpapersImageNames
        listBoard.mainBG = self.mainBG
        listBoard.blurredView = self.blurredView
        listBoard.logoImageView = self.logoImageView
        listBoard.descriptionImageView = self.descriptionImageView
        listBoard.player = self.player
        
        print(self.blurredView.alpha)
        
        navigationController?.pushViewController(listBoard, animated: false)
    }
    
    @objc func fireTimer() {
        let randomWallpaper = wallpapersImageNames.randomElement()
        if randomWallpaper == currentRandomWallpaper {
            
        }
        UIView.transition(with: mainBG, duration: 2, options: .transitionCrossDissolve, animations: {
            self.mainBG.image = UIImage(named: self.wallpaperRandomUtility())
        }, completion: nil)
    }
}

