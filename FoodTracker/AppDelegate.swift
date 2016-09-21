//
//  AppDelegate.swift
//  FoodTracker
//
//  Created by Kevin Harris on 9/14/16.
//  Copyright © 2016 Guild/SA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let VERSION_NUM = "v1"
    let APP_ID = "F2C2DCED-C64B-3639-FFE7-1DCAD9C23C00"
    let SECRET_KEY = "592D0F41-FE91-2925-FF75-C228378D4B00"

    let EMAIL = "ios_user@gmail.com" // Doubles as User Name
    let PASSWORD = "password"
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // First, init Backendless!
        let backendless = Backendless.sharedInstance()
        backendless?.initApp(APP_ID, secret:SECRET_KEY, version:VERSION_NUM)
        backendless?.userService.setStayLoggedIn(true)

        
        // Next, check if the user is already logged in. If they are - do nothing else!
        let isValidUser = backendless?.userService.isValidUserToken()
        
        if isValidUser != nil && isValidUser != 0 {
            
            // The user has a valid user token so we know for sure the user is already logged!
            print("User is already logged: \(isValidUser?.boolValue)");
            
        } else {
            
            // If the user is not logged in, register the test user,
            // and if that suceeds, go ahead and log them in.
            
            let user: BackendlessUser = BackendlessUser()
            user.email = EMAIL as NSString!
            user.password = PASSWORD as NSString!
            
            backendless?.userService.registering( user,
                                                 
            response: { (user: BackendlessUser?) -> Void in
                
                    print("User was registered: \(user?.objectId)")
                
                    backendless?.userService.login( self.EMAIL, password: self.PASSWORD,
    
                        response: { (user: BackendlessUser?) -> Void in
                            print("User logged in: \(user!.objectId)")
                        },
        
                       error: { (fault: Fault?) -> Void in
                            print("User failed to login: \(fault)")
                        }
                    )
                },
                                                     
                error: { (fault: Fault?) -> Void in
                    print("User failed to register: \(fault)")
                }
            )
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

