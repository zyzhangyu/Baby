//  Created by josh on 2020/07/23.

#if canImport(UIKit)
#if canImport(AVFoundation)
import AVFoundation
import UIKit
import Vision

/// Conform to this delegate to get notified of key events
@available(iOS 13, *)
public protocol IDCardScannerViewControllerDelegate: AnyObject {
    /// Called user taps the cancel button. Comes with a default implementation for UIViewControllers.
    ///  被用户点击取消按钮,带有一个UIViewControllers的默认实现.
    /// - Warning: The viewController does not auto-dismiss. You must dismiss the viewController
    /// - 警告:这个viewController不会自动关闭.你必须关闭viewController.
    func idCardScannerViewControllerDidCancel(_ viewController: IDCardScannerViewController)
    /// Called when an error is encountered
    // 当遇到错误的时候会被调用
    func idCardScannerViewController(_ viewController: IDCardScannerViewController, didErrorWith error: IDCardScannerError)
    /// Called when finished successfully
    /// 成功完成时调用
    /// - Note: successful finish does not guarentee that all credit card info can be extracted
    /// - 注意: 成功完成并不保证可以提取所有信用卡信息
    func idCardScannerViewController(_ viewController: IDCardScannerViewController, didFinishWith card: IDCard)
}

@available(iOS 13, *)
public extension IDCardScannerViewControllerDelegate where Self: UIViewController {
    func idCardScannerViewControllerDidCancel(_ viewController: IDCardScannerViewController) {
        viewController.dismiss(animated: true)
    }
}

@available(iOS 13, *)
open class IDCardScannerViewController: UIViewController {
    /// public propaties
    public var titleLabelText: String = "Add card"
    public var subtitleLabelText: String = "Line up card within the lines"
    public var cancelButtonTitleText: String = "Cancel"
    public var cancelButtonTitleTextColor: UIColor = .blue
    public var labelTextColor: UIColor = .systemPink
    public var textBackgroundColor: UIColor = .purple
    public var cameraViewIDCardFrameStrokeColor: UIColor = .cyan
    public var cameraViewMaskLayerColor: UIColor = .yellow
    public var cameraViewMaskAlpha: CGFloat = 0.7

    // MARK: - Subviews and layers
    
    ///绘制矩形的layer
    private var maskLayer = CAShapeLayer()


    /// View representing live camera
    private lazy var cameraView: CameraView = CameraView(
        delegate: self,
        idCardFrameStrokeColor: self.cameraViewIDCardFrameStrokeColor,
        maskLayerColor: self.cameraViewMaskLayerColor,
        maskLayerAlpha: self.cameraViewMaskAlpha
    )

    /// Analyzes text data for credit card info
    private lazy var analyzer = ImageAnalyzer(delegate: self)

    private weak var delegate: IDCardScannerViewControllerDelegate?

    /// The backgroundColor stack view that is below the camera preview view
    private var bottomStackView = UIStackView()
    private var titleLabel = UILabel()
    private var subtitleLabel = UILabel()
    private var cancelButton = UIButton(type: .system)
    
    
    ///从识别到的矩形上 补货到的照片
    private var aview:UIImageView = UIImageView.init()

    // MARK: - Vision-related

    public init(delegate: IDCardScannerViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    

    override open func viewDidLoad() {
        super.viewDidLoad()
        layoutSubviews()
        setupLabelsAndButtons()
        
        ///镜头采集 用户认证
        AVCaptureDevice.authorize { [weak self] authoriazed in
            // 这是在主线程执行的
            guard let strongSelf = self else {
                return
            }
            guard authoriazed else {
                strongSelf.delegate?.idCardScannerViewController(strongSelf, didErrorWith: IDCardScannerError(kind: .authorizationDenied, underlyingError: nil))
                return
            }
            strongSelf.cameraView.setupCamera()
        }
        /// 用来展示从图片上截出的矩形的imageview
        aview = UIImageView.init(frame: CGRect.init(x: 50, y: 700, width: 200, height: 200))
        aview.backgroundColor = .brown
        aview.contentMode = .scaleAspectFit
        self.view .addSubview(aview)
    }

    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.setupRegionOfInterest()
    }
}

@available(iOS 13, *)
private extension IDCardScannerViewController {
    @objc func cancel(_ sender: UIButton) {
        delegate?.idCardScannerViewControllerDidCancel(self)
    
    }

    func layoutSubviews() {
        view.backgroundColor = textBackgroundColor
        // TODO: test screen rotation cameraView, cutoutView
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraView)
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            cameraView.heightAnchor.constraint(equalTo: cameraView.widthAnchor, multiplier: IDCard.heightRatioAgainstWidth, constant: 100),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.topAnchor.constraint(equalTo: cameraView.bottomAnchor),
        ])

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])

        bottomStackView.axis = .vertical
        bottomStackView.spacing = 16.0
        bottomStackView.isLayoutMarginsRelativeArrangement = true
        bottomStackView.distribution = .equalSpacing
        bottomStackView.directionalLayoutMargins = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        let arrangedSubviews: [UIView] = [titleLabel, subtitleLabel]
        arrangedSubviews.forEach(bottomStackView.addArrangedSubview)
    }

    ///UI 设置
    func setupLabelsAndButtons() {
        titleLabel.text = titleLabelText
        titleLabel.textAlignment = .center
        titleLabel.textColor = labelTextColor
        titleLabel.font = .preferredFont(forTextStyle: .largeTitle)
        subtitleLabel.text = subtitleLabelText
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = .preferredFont(forTextStyle: .title3)
        subtitleLabel.textColor = labelTextColor
        subtitleLabel.numberOfLines = 0
        cancelButton.setTitle(cancelButtonTitleText, for: .normal)
        cancelButton.setTitleColor(cancelButtonTitleTextColor, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    
    /// 识别矩形时 移除之前绘制的矩形
    func removeMask() {
        maskLayer.removeFromSuperlayer()
    }
    
    ///绘制 边界框  归一化坐标系 转化为 CGRect坐标系
    func drawBoundingBox(rect : VNRectangleObservation) -> CGRect {
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.view.frame.height)
        ///比例
        let scale = CGAffineTransform.identity.scaledBy(x: self.view.frame.width, y: self.view.frame.height)
        let bounds = rect.boundingBox.applying(scale).applying(transform)
        createLayer(in: bounds)
        return bounds
    }
    
    /// 上面的方法计算边框  绘画边框
    private func createLayer(in rect: CGRect)  {

        maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.cornerRadius = 10
        maskLayer.opacity = 0.75
        maskLayer.borderColor = UIColor.red.cgColor
        maskLayer.borderWidth = 5.0
        print("红色线框的rect", rect , "整个页面多大", self.view.frame)
        self.cameraView.layer.insertSublayer(maskLayer, at: 1)
    }
    
    
//    ///透视 矫正
//    func doPerspectiveCorrection(_ observation: VNRectangleObservation, from buffer: CVImageBuffer) {
//        var ciImage = CIImage(cvImageBuffer: buffer)
//
//        let topLeft = observation.topLeft.scaled(to: ciImage.extent.size)
//        let topRight = observation.topRight.scaled(to: ciImage.extent.size)
//        let bottomLeft = observation.bottomLeft.scaled(to: ciImage.extent.size)
//        let bottomRight = observation.bottomRight.scaled(to: ciImage.extent.size)
//
//        // pass those to the filter to extract/rectify the image
//        ciImage = ciImage.applyingFilter("CIPerspectiveCorrection", parameters: [
//            "inputTopLeft": CIVector(cgPoint: topLeft),
//            "inputTopRight": CIVector(cgPoint: topRight),
//            "inputBottomLeft": CIVector(cgPoint: bottomLeft),
//            "inputBottomRight": CIVector(cgPoint: bottomRight),
//        ])
//
//        let context = CIContext()
//        let cgImage = context.createCGImage(ciImage, from: ciImage.extent)
//        let output = UIImage(cgImage: cgImage!)
//        //UIImageWriteToSavedPhotosAlbum(output, nil, nil, nil)
//
//        let secondVC = TextExtractorVC()
//        secondVC.scannedImage = output
//        self.navigationController?.pushViewController(secondVC, animated: false)
//
//    }
}

@available(iOS 13, *)
///
extension IDCardScannerViewController: CameraViewDelegate {
    func didCapture(in image: CVPixelBuffer) {
        
        let request = VNDetectRectanglesRequest(completionHandler: { (request: VNRequest, error: Error?) in
            DispatchQueue.main.async { [self] in
                print("识别中")
                
                guard let results = request.results as? [VNRectangleObservation] else { return }
                self.removeMask()
                
                guard let rect = results.first else{
                    print("没有识别出来身份证所在的矩形框")
                    return
                }
                    
                print("识别出来了身份证所在的矩形框,下一步准备将矩形框从图片中切割出来 然后去识别矩形框内的中文内容")
                ///绘制识别出来的矩形框
                var arect = self.drawBoundingBox(rect: rect)
 
//                    if self.isTapped{
//                        self.isTapped = false
//                        self.doPerspectiveCorrection(rect, from: image)
//                    }
//                print("图片截取的rect", arect, "整个图片的rect", ciImage.extent)
//                let context = CIContext()
//                let cgImage = context.createCGImage(ciImage, from: arect)
//                let output = UIImage(cgImage: cgImage!)
//
//                print("存到相册里了")
//                UIImageWriteToSavedPhotosAlbum(output, nil, nil, nil)
                let ciImage = CIImage(cvImageBuffer: image)
                let srcWidth = CGFloat(ciImage.extent.width)
                let srcHeight = CGFloat(ciImage.extent.height)
                let dstWidth: CGFloat = arect.width
                let dstHeight: CGFloat = arect.height
                let scaleX = dstWidth / srcWidth
                let scaleY = dstHeight / srcHeight
                let scale = min(scaleX, scaleY)
                let transform = CGAffineTransform.init(scaleX: scale, y: scale)
//                ///有
//                let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.view.frame.height)
//                ///比例 有
                let scale222 = CGAffineTransform.identity.scaledBy(x: self.view.frame.width, y: self.view.frame.height)
                let bounds = rect.boundingBox.applying(scale222).applying(transform)
                
                let context = CIContext()
                let cgImage = context.createCGImage(ciImage, from: bounds)
                let output = UIImage(cgImage: cgImage!)
                self.aview.image = output
                

                self.analyzer.analyze(image: cgImage!)
            }
        })
        
        request.minimumAspectRatio = VNAspectRatio(0.6)
        request.maximumAspectRatio = VNAspectRatio(0.7)
        request.minimumSize = Float(0.5)
        request.maximumObservations = 1
        /// CVPixelBuffer 这个是 图像捕捉穿过来的图片格式
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: image, options: [:])
        try? imageRequestHandler.perform([request])
    }
    
    ///拍摄然后开始解析
    internal func didCapture(image: CGImage) {
        
        print("先解析矩形 确认矩形之后 在做身份证是被")
        print("开始解析图片 开始解析图片 开始解析图片")
        print("打印识别矩形函数执行所在的线程",Thread.current)
        analyzer.analyze(image: image)
    }

    internal func didError(with error: IDCardScannerError) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.idCardScannerViewController(strongSelf, didErrorWith: error)
            strongSelf.cameraView.stopSession()
        }
    }
}

@available(iOS 13, *)
extension IDCardScannerViewController: ImageAnalyzerProtocol {
    internal func didFinishAnalyzation(with result: Result<IDCard, IDCardScannerError>) {
        switch result {
        case let .success(creditCard):
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.cameraView.stopSession()
                strongSelf.delegate?.idCardScannerViewController(strongSelf, didFinishWith: creditCard)
            }

        case let .failure(error):
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.cameraView.stopSession()
                strongSelf.delegate?.idCardScannerViewController(strongSelf, didErrorWith: error)
            }
        }
    }
}

@available(iOS 13, *)
///镜头采集
extension AVCaptureDevice {
    ///用户授权
    static func authorize(authorizedHandler: @escaping ((Bool) -> Void)) {
        let mainThreadHandler: ((Bool) -> Void) = { isAuthorized in
            DispatchQueue.main.async {
                authorizedHandler(isAuthorized)
            }
        }

        switch authorizationStatus(for: .video) {
        case .authorized:
            mainThreadHandler(true)
        case .notDetermined://用户暂时没有做相关选着
            requestAccess(for: .video, completionHandler: { granted in
                mainThreadHandler(granted)
})
        default:
            mainThreadHandler(false)
        }
    }
}
#endif
#endif

extension CGPoint {
   func scaled(to size: CGSize) -> CGPoint {
       return CGPoint(x: self.x * size.width,
                      y: self.y * size.height)
   }
}
