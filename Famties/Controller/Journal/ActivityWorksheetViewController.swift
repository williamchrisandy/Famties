//
//  WorksheetDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 20/06/22.
//

import UIKit
import PencilKit

class ActivityWorksheetViewController: UIViewController, PKCanvasViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var worksheetView: UIView!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageUpButton: UIButton!
    @IBOutlet weak var pageDownButton: UIButton!
    @IBOutlet weak var pageIndicatorLabel: UILabel!
    
    
    let DBHelper = DatabaseHelper()
    weak var editDelegate: EditControllerDelegate?
    var journal: Journal?
    var canvasDrawing: [PKDrawing] = []
    var toolPicker = PKToolPicker()
    var worksheetImage: [UIImage]!
    var pageCount: Int!
    var currentPage: Int!
    
    
    //MARK: Initialization
    override func viewDidLoad() {
        initDesign()
        initVar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var changed = false
        for worksheet in journal?.worksheets?.allObjects as! [Worksheet] {
            var sx = canvasView.visibleSize.width / worksheet.width
            var sy = canvasView.visibleSize.height / worksheet.height
            
            if sx.isInfinite { sx = 1 }
            if sy.isInfinite { sy = 1 }
            
            if sx != 1 || sy != 1 {
                changed = true
                canvasDrawing[Int(worksheet.index)].transform(using: CGAffineTransform(scaleX: sx, y: sy))
            }
        }
        if changed == true {
            canvasView.drawing = canvasDrawing[currentPage]
        }
    }
    
    func initDesign(){
        canvasView.layer.borderWidth = 1
    }
    
    func initVar(){
        worksheetImage = journal?.activity?.worksheetImage
        pageCount = worksheetImage.count
        currentPage = 0
        let worksheets = journal?.worksheets?.allObjects as! [Worksheet]
        for worksheet in worksheets.sorted(by: { $0.index < $1.index }) {
            do{
                canvasDrawing.append(try PKDrawing(data: worksheet.data!))
            } catch {
                print(error)
            }
        }
        
        canvasView.drawing = canvasDrawing[0]
        canvasView.delegate = self
        toolPicker.selectedTool = PKInkingTool(.pen, color: .black, width: 5)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        
        refreshContent()
    }
    
    
    //MARK: Functions
    func refreshContent(){
        canvasView.drawing = canvasDrawing[currentPage]
        imageView.image = worksheetImage[currentPage]
        pageIndicatorLabel.text = String(currentPage+1) + "/" + String(pageCount)
    }
    
    func saveDrawing(){
        canvasDrawing[currentPage] = canvasView.drawing
        
    }
    
    
    //MARK: Actions
    @IBAction func pageUp(_ sender: Any) {
        saveDrawing()
        if currentPage > 0 {
            currentPage -= 1
            refreshContent()
        }
    }
    
    @IBAction func pageDown(_ sender: Any) {
        saveDrawing()
        if currentPage < pageCount-1 {
            currentPage += 1
            refreshContent()
        }
    }
    
    //MARK: Overrides
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        editDelegate?.updateEditStatus()
    }
}

extension ActivityWorksheetViewController: EmbeddedViewControllerDelegate {
    func showLeftView() {
        canvasView.becomeFirstResponder()
        self.view.isHidden = false
    }
    
    func showRightView() {
        canvasView.resignFirstResponder()
        self.view.isHidden = true
    }
    
    func saveJournalData() {
        saveDrawing()
        let sheets = journal?.worksheets?.allObjects as! [Worksheet]
        
        for i in 0...(pageCount-1){
            let index = Int(sheets[i].index)
            sheets[i].data = canvasDrawing[index].dataRepresentation()
            sheets[i].width = canvasView.visibleSize.width
            sheets[i].height = canvasView.visibleSize.height
        }
        
        //        DBHelper.saveContext()
    }
}
