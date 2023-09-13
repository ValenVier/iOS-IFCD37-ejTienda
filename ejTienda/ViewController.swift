//
//  ViewController.swift
//  ejTienda
//
//  Created by AlumnoPro on 30/09/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var array:[Producto] = []
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabla.dataSource = self
        tabla.delegate = self
        tabla.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        getDatos()
        tabla.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    @IBAction func add(_ sender: Any) {
        if input1.text != "", input2.text != ""{
            let productoAdd = Producto(context: self.context)
            productoAdd.nombre = input1.text
            productoAdd.precio = (input2.text! as NSString).floatValue
            guardar()
        }
        input1.text = ""
        input2.text = ""
    }
    func getDatos(){
        do {
            self.array = try context.fetch(Producto.fetchRequest())
            DispatchQueue.main.async {
                self.tabla.reloadData()
            }
        } catch {
            print("tarea fallada satisfactoriamente")
        }
    }
    
    func guardar(){
        do {
            try self.context.save()
            getDatos()
        } catch {
            print("error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tabla.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as? TableViewCell
        celda?.producto.text = array[indexPath.row].nombre
        celda?.precio.text = String(array[indexPath.row].precio)
        return celda!
        
        
    }

    func lanzarAlerta (productoEditar: Producto){
        let alert = UIAlertController(title: "ALERTA", message: "vas a editar \(productoEditar.nombre!)" , preferredStyle: .alert)
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .cyan
//        alert.setValue(NSAttributedString(string: "message", attributes: [NS]), forKey: <#T##String#>)
        alert.addTextField()
        alert.addTextField()
        
        alert.textFields![0].superview?.layer.borderWidth = 1
        alert.textFields![0].superview?.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        alert.textFields![0].superview?.backgroundColor = .systemYellow
        alert.addAction(UIAlertAction(title: "EDITAR", style: .default){
            (_) in let campoTexto = alert.textFields![0]
            let campoTexto2 = alert.textFields![1]
            if campoTexto.text != "", campoTexto2.text != ""{
                productoEditar.nombre = campoTexto.text
                productoEditar.precio = (campoTexto2.text! as NSString).floatValue
                self.guardar()
            }
        })
        alert.addAction(UIAlertAction(title: "CANCELAR", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let accion = UIContextualAction(style: .normal, title: "editar"){
            (_,_,_) in let productoEditar = self.array[indexPath.row]
            self.lanzarAlerta(productoEditar: productoEditar)
        }
        accion.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [accion])
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let accion = UIContextualAction(style: .destructive, title: "eliminar"){
            (_,_,_) in let productoEliminar = self.array[indexPath.row]
            self.context.delete(productoEliminar)
            self.guardar()
        }
        return UISwipeActionsConfiguration(actions: [accion])
    }
}

