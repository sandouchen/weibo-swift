//
//  AppDelegate.m
//  练习
//
//  Created by fqq3 on 2017/9/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "AppDelegate.h"
#import "SDTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SDTableViewController *vc = [[SDTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
