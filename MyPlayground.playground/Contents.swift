import UIKit
import PlaygroundSupport
import AVFoundation

class MainBoard: UIViewController {
    
    let frameSize = CGRect(x: 0, y: 0, width: 600, height: 800)
    var mainBG: UIImageView!
    var blurredView: UIView!
    var logoImageView: UIImageView!
    var descriptionImageView: UIImageView!
    var indonesiaIcon: UIImageView!
    var nextButton: UIButton!
    let wallpapersImageNames = ["a2", "a3", "a4", "a7", "a8", "wallpaper1", "wallpaper2", "wallpaper3"]
    var currentRandomWallpaper = "a8"
    var player: AVAudioPlayer?
    
    var timer: Timer?
    
    var creditLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        mainBG = UIImageView(frame: frameSize)
        mainBG.image = UIImage(named: currentRandomWallpaper)
        mainBG.contentMode = .scaleAspectFill
        view.addSubview(mainBG)
        
        blurredView = UIView(frame: frameSize)
        blurredView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        view.addSubview(blurredView)
        
        nextButton = UIButton(type: UIButton.ButtonType.system)
        nextButton.frame = CGRect(x: 150, y: 670, width: 300, height: 70)
        nextButton.backgroundColor = UIColor(red: 87/255, green: 154/255, blue: 9/255, alpha: 1)
        nextButton.tintColor = .white
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 25)
        view.addSubview(nextButton)
        
        logoImageView = UIImageView(frame: CGRect(x: 150, y: 40, width: 300, height: 70))
        logoImageView.image = UIImage(named: "Bookonesia3x")
        view.addSubview(logoImageView)
        
        descriptionImageView = UIImageView(frame: CGRect(x: 125, y: 120, width: 350, height: 40))
        descriptionImageView.image = UIImage(named: "description")
        descriptionImageView.contentMode = .scaleAspectFit
        view.addSubview(descriptionImageView)
        
        indonesiaIcon = UIImageView(image: UIImage(named: "indonesia"))
        indonesiaIcon.contentMode = .scaleAspectFit
        indonesiaIcon.frame = CGRect(x: 150, y: 300, width: 300, height: 200)
        view.addSubview(indonesiaIcon)
        
        creditLabel = UILabel()
        creditLabel.textColor = .white
        creditLabel.adjustsFontSizeToFitWidth = true
        creditLabel.text = "Icon made by Freepik from www.flaticon.com"
        creditLabel.frame = CGRect(x: 225, y: 480, width: 150, height: 15)
        view.addSubview(creditLabel)
        
        nextButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
        playSound()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func startButtonTapped() {
        let descriptionBoard = DescriptionBoard()
        descriptionBoard.currentRandomWallpaper = self.currentRandomWallpaper
        descriptionBoard.wallpapersImageNames = self.wallpapersImageNames
        descriptionBoard.frameSize = self.frameSize
        descriptionBoard.player = self.player
        
        navigationController?.pushViewController(descriptionBoard, animated: false)
    }
    
    var ttt = 0
    @objc func fireTimer() {
        print(ttt)
        ttt += 1
        let randomWallpaper = wallpapersImageNames.randomElement()
        if randomWallpaper == currentRandomWallpaper {
            
        }
        UIView.transition(with: mainBG, duration: 2, options: .transitionCrossDissolve, animations: {
            self.mainBG.image = UIImage(named: self.wallpaperRandomUtility())
        }, completion: nil)
    }
    
    func wallpaperRandomUtility() -> String {
        let random = wallpapersImageNames.randomElement()
        if random == currentRandomWallpaper {
            self.wallpaperRandomUtility()
        } else {
            currentRandomWallpaper = random!
        }
        return currentRandomWallpaper
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "backsound", withExtension: "m4a")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
        } catch {
            
        }
    }
}

let mainBoard = MainBoard()
mainBoard.preferredContentSize = CGSize(width: 600, height: 750)
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = UINavigationController(rootViewController: mainBoard)
