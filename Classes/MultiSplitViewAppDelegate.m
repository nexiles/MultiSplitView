//
//  MultiSplitViewAppDelegate.m
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 09.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import "MultiSplitViewAppDelegate.h"

#import "ViewRegistry.h"
#import "NXDataLoader.h"

#import "OrgDetailViewController.h"
#import "OrgRootViewController.h"


@implementation MultiSplitViewAppDelegate

@synthesize window, splitViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSLog(@"%s", __func__);

  //ViewRegistry *registry = [ViewRegistry sharedViewRegistry];

  //[registry registerViewController: [[OrgRootViewController alloc] init] forName: @"organization.root"];
  //[registry registerViewController: [[OrgDetailViewController alloc] init] forName: @"organization.detail"];


  //NSArray *viewControllers = [NSArray arrayWithObjects:
          //[registry controllerForName:@"organization.root"],
          //[registry controllerForName:@"organization.detail"],
          //nil];

  //self.splitViewController.viewControllers = viewControllers;

  NSLog(@"%s: self.splitViewController.viewControllers=%@", __func__, self.splitViewController.viewControllers);
  NSLog(@"%s: self.splitViewController.viewControllers 0=%@", __func__, [[self.splitViewController.viewControllers objectAtIndex:0] viewControllers]);
  NSLog(@"%s: self.splitViewController.viewControllers 1=%@", __func__, [[self.splitViewController.viewControllers objectAtIndex:1] viewControllers]);
  

  // Add the split view controller's view to the window and display.
  [self.window addSubview:splitViewController.view];
  [self.window makeKeyAndVisible];

  return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [splitViewController release];
    [window release];
    [super dealloc];
}


@end
// vim: set ts=2 sw=2 expandtab:

