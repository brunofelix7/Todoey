import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //  MARK: Imprime o diretorio do simulador para poder ir ate on o arquivo defaults esta armazenado
        /*
         Users/indra/Library/Developer/CoreSimulator/Devices/E5383744-5174-40F8-8AB5-4394F0EE0F7A/data/Containers/
         Data/Application/DA8428A7-D35F-467D-B6B8-44D42F1BE6A1/Library/Preferences/com.bfcodeofficial.Todoey.plist
         */
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    //  MARK: Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("persistentContainer() Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("saveContext() Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
