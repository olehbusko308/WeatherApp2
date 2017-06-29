//
//  AppDelegate.h
//  WeatherApp2
//
//  Created by Oleh Busko on 31/05/2017.
//  Copyright © 2017 Oleh Busko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

-(void) saveContext;

@end

