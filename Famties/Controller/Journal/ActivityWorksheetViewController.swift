//
//  WorksheetDetailViewController.swift
//  Famties
//
//  Created by Hilmy Veradin on 20/06/22.
//

import UIKit
import PencilKit

class ActivityWorksheetViewController: UIViewController {
    
    @IBOutlet weak var worksheetView: UIView!
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pageUpButton: UIButton!
    @IBOutlet weak var pageDownButton: UIButton!
    @IBOutlet weak var pageIndicatorLabel: UILabel!
    
    
    var canvasDrawing: [PKDrawing] = []
    var toolPicker = PKToolPicker()
    
    let worksheetImage = ["Activity1_Worksheet1", "Activity1_Worksheet2"]
    var pageCount: Int!
    var currentPage: Int!
    
    override func viewDidLoad() {
        
        pageCount = worksheetImage.count
        currentPage = 0
        
        for _ in 1...pageCount{
            canvasDrawing.append(PKDrawing())
        }
        
        
        canvasView.drawing = canvasDrawing[0]
        toolPicker.selectedTool = PKInkingTool(.pen, color: .black, width: 5)
        toolPicker.addObserver(canvasView)
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        canvasView.becomeFirstResponder()
        
        refreshContent()
    }
    
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
    
    func refreshContent(){
        canvasView.drawing = canvasDrawing[currentPage]
        imageView.image = UIImage(named: worksheetImage[currentPage])
        pageIndicatorLabel.text = String(currentPage+1) + "/" + String(pageCount)
        print("loaded")
    }
    
    func saveDrawing(){
        canvasDrawing[currentPage] = canvasView.drawing
    }
    
    
    
}

extension ActivityWorksheetViewController: EmbeddedViewControllerDelegate {
    func showLeftView() {
        self.view.alpha = 1
        toolPicker.setVisible(true, forFirstResponder: canvasView)
    }
    
    func showRightView() {
        self.view.alpha = 0
        toolPicker.setVisible(false, forFirstResponder: canvasView)
    }
    
    func loadBothView() {
        self.view.alpha = 1
    }
    
}
