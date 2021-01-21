
#if canImport(UIKit)
#if canImport(AVFoundation)

import AVFoundation
import UIKit
import VideoToolbox

protocol CameraViewDelegate: AnyObject {
    func didCapture(in image:CVPixelBuffer)
    func didCapture(image: CGImage)
    func didError(with: IDCardScannerError)
}

@available(iOS 13, *)
final class CameraView: UIView {
    weak var delegate: CameraViewDelegate?
    private let idCardFrameStrokeColor: UIColor
    private let maskLayerColor: UIColor
    private let maskLayerAlpha: CGFloat

    // MARK: - Capture related
    private let captureSessionQueue = DispatchQueue(
        label: "com.zhangyu.id-card-scanner.captureSessionQueue"
    )

    // MARK: - Capture related
    private let sampleBufferQueue = DispatchQueue(
        label: "com.zhangyu.id-card-scanner.sampleBufferQueue"
    )

    init(
        delegate: CameraViewDelegate,
        idCardFrameStrokeColor: UIColor,
        maskLayerColor: UIColor,
        maskLayerAlpha: CGFloat
    ) {
        self.delegate = delegate
        self.idCardFrameStrokeColor = idCardFrameStrokeColor
        self.maskLayerColor = maskLayerColor
        self.maskLayerAlpha = maskLayerAlpha
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let imageRatio: ImageRatio = .vga640x480

    // MARK: - Region of interest and text orientation

    /// Region of video data output buffer that recognition should be run on.
    /// Gets recalculated once the bounds of the preview layer are known.
    private var regionOfInterest: CGRect?
    
    
    ///卡片图层
    public var publicCuttedRect : CGRect?
    
    ///预览图层
    public var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
        }

        return layer
    }

    private var videoSession: AVCaptureSession? {
        get {
            videoPreviewLayer.session
        }
        set {
            videoPreviewLayer.session = newValue
        }
    }

    let semaphore = DispatchSemaphore(value: 1)

    override class var layerClass: AnyClass {
        AVCaptureVideoPreviewLayer.self
    }

    func stopSession() {
        videoSession?.stopRunning()
    }

    func startSession() {
        videoSession?.startRunning()
    }

    func setupCamera() {
        captureSessionQueue.async { [weak self] in
            self?._setupCamera()
        }
    }

    private func _setupCamera() {
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = imageRatio.preset

        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                        for: .video,
                                                        position: .back) else {
            delegate?.didError(with: IDCardScannerError(kind: .cameraSetup))
            return
        }
        /// 重点 把相机图像加入到图像采集 也就是指定了图像采集的设备
        do {
            let deviceInput = try AVCaptureDeviceInput(device: videoDevice)
            session.canAddInput(deviceInput)
            session.addInput(deviceInput)
        } catch {
            delegate?.didError(with: IDCardScannerError(kind: .cameraSetup, underlyingError: error))
        }

        ///图像采集输出
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: sampleBufferQueue)

        guard session.canAddOutput(videoOutput) else {
            delegate?.didError(with: IDCardScannerError(kind: .cameraSetup))
            return
        }

        /// 最后把输入要给到图片你分析
        session.addOutput(videoOutput)
        session.connections.forEach {
            $0.videoOrientation = .portrait
        }
        session.commitConfiguration()

        DispatchQueue.main.async { [weak self] in
            self?.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self?.videoSession = session
            self?.startSession()
        }
    }
    
    ///设置兴趣范围
    func setupRegionOfInterest() {
        guard regionOfInterest == nil else { return }
        /// Mask layer that covering area around camera view
        /// 遮罩层，覆盖摄像机视图周围的区域。

        let backLayer = CALayer()
        backLayer.frame = bounds
        backLayer.backgroundColor = maskLayerColor.withAlphaComponent(maskLayerAlpha).cgColor

        //  culcurate cutoutted frame
        //  精确的剪裁框架
        let cuttedWidth: CGFloat = bounds.width - 40.0
        let cuttedHeight: CGFloat = cuttedWidth * IDCard.heightRatioAgainstWidth

        let centerVertical = (bounds.height / 2.0)
        let cuttedY: CGFloat = centerVertical - (cuttedHeight / 2.0)
        let cuttedX: CGFloat = 20.0

        let cuttedRect = CGRect(x: cuttedX,
                                y: cuttedY,
                                width: cuttedWidth,
                                height: cuttedHeight)
        
        publicCuttedRect = cuttedRect;
        ///根据路径绘制的矢量图层
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: cuttedRect, cornerRadius: 10.0)

        path.append(UIBezierPath(rect: bounds))
        maskLayer.path = path.cgPath
        
        //        CA_EXTERN NSString *const kCAFillRuleNonZero    //非零
        //        CA_EXTERN NSString *const kCAFillRuleEvenOdd    //齐偶
        //        even-odd 奇偶判断规则，从任意一点出发 与边界交点个数为
        //        奇数则表示在圆或者说图形内，如果为偶数表示在圆外或者说图形外  奇数时在圆内
        maskLayer.fillRule = .evenOdd ///填充规则，默认非零法则，奇偶原则     EvenOdd奇偶
        backLayer.mask = maskLayer
        layer.addSublayer(backLayer)
        
        ///照相机的矩形框
        let strokeLayer = CAShapeLayer()
        strokeLayer.lineWidth = 3.0
        strokeLayer.strokeColor = idCardFrameStrokeColor.cgColor
        strokeLayer.path = UIBezierPath(roundedRect: cuttedRect, cornerRadius: 10.0).cgPath
        strokeLayer.fillColor = nil
        layer.addSublayer(strokeLayer)

        let imageHeight: CGFloat = imageRatio.imageHeight
        let imageWidth: CGFloat = imageRatio.imageWidth

        let acutualImageRatioAgainstVisibleSize = imageWidth / bounds.width
        let interestX = cuttedRect.origin.x * acutualImageRatioAgainstVisibleSize
        let interestWidth = cuttedRect.width * acutualImageRatioAgainstVisibleSize
        let interestHeight = interestWidth * IDCard.heightRatioAgainstWidth
        let interestY = (imageHeight / 2.0) - (interestHeight / 2.0)
        regionOfInterest = CGRect(x: interestX,
                                  y: interestY,
                                  width: interestWidth,
                                  height: interestHeight)
    }
}

@available(iOS 13, *)
///实时的获取摄像头的视频流，通过解析数据流，可以进行实时的业务处理
extension CameraView: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    ///结构相机帧
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        ///信号标
        semaphore.wait()
        ///等一个信号
        defer { semaphore.signal() }

        ///来一个像素缓冲
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            delegate?.didError(with: IDCardScannerError(kind: .capture))
            delegate = nil
            return
        }
        
        delegate?.didCapture(in: pixelBuffer);
        
        
//        var cgImage: CGImage?
//        ///搞一张照片出来
//        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)
//
//        ///确定兴趣范围
//        guard let regionOfInterest = regionOfInterest else {
//            return
//        }
//
//        ///全部的图片信息
//        guard let fullCameraImage = cgImage,
//              ///从整个图片里剪裁敢兴趣的图片信息
//            let croppedImage = fullCameraImage.cropping(to: regionOfInterest) else {
//            delegate?.didError(with: IDCardScannerError(kind: .capture))
//            delegate = nil
//            return
//        }
//
//        delegate?.didCapture(image: croppedImage)
    }
}
#endif
#endif

extension IDCard {
    static let heightRatioAgainstWidth: CGFloat = 0.6180469716
}
