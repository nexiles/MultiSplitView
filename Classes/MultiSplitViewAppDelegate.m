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
#import "ProductDetailViewController.h"
#import "ProductRootViewController.h"

@interface MultiSplitViewAppDelegate ()
-(void)configureRootViews;
-(void)pushSplitViewControllers:(NSString *)name withData:(NSDictionary *)data;
-(void)pushNotification:(NSNotification *)note;
@end

@implementation MultiSplitViewAppDelegate

@synthesize window, splitViewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSLog(@"%s", __func__);

  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];

  [registry registerRootController:[[OrgRootViewController alloc] initWithNibName:@"OrgRootViewController" bundle:nil]
                           forName:@"organization"];
  [registry registerDetailController:[[OrgDetailViewController alloc] initWithNibName:@"OrgDetailViewController" bundle:nil]
                           forName:@"organization"];

  [registry registerRootController:[[ProductRootViewController alloc] initWithNibName:@"ProductRootViewController" bundle:nil]
                           forName:@"product"];
  [registry registerDetailController:[[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil]
                           forName:@"product"];

  [self configureRootViews];

  NSLog(@"%s: self.splitViewController.viewControllers=%@", __func__, self.splitViewController.viewControllers);
  NSLog(@"%s: self.splitViewController.viewControllers 0=%@", __func__, [[self.splitViewController.viewControllers objectAtIndex:0] viewControllers]);
  NSLog(@"%s: self.splitViewController.viewControllers 1=%@", __func__, [[self.splitViewController.viewControllers objectAtIndex:1] viewControllers]);

  // Register for "push" View Controller notifications
  NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
  [nc addObserver:self selector:@selector(pushNotification:) name:@"push_notification" object:nil];

  // Add the split view controller's view to the window and display.
  [self.window addSubview:splitViewController.view];
  [self.window makeKeyAndVisible];

  return YES;
}

#pragma mark -
#pragma mark Split View Controller handling

-(void)pushNotification:(NSNotification *)note
{
  NSLog(@"%s: note=%@", __func__, note);

  NSDictionary *info = [note userInfo];

  NSString *controller_name = [info objectForKey:@"controller_name"];
  NSDictionary *data        = [info objectForKey:@"data"];

  [self pushSplitViewControllers:controller_name withData:data];
}

-(void)configureRootViews
{
  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];

  RootViewController *rootVC = [registry rootControllerForName:@"organization"];
  NSLog(@"%s: rootVC=%@", __func__, rootVC);

  DetailViewController *detailVC = [registry detailControllerForName:@"organization"];
  NSLog(@"%s: detailVC=%@", __func__, detailVC);
  
  rootVC.detailView = detailVC;

  NSArray *viewControllers = [NSArray arrayWithObjects:
          [[UINavigationController alloc] initWithRootViewController:rootVC],
          [[UINavigationController alloc] initWithRootViewController:detailVC],
          nil];

  self.splitViewController.viewControllers = viewControllers;
  self.splitViewController.delegate = detailVC;
}

-(void)pushSplitViewControllers:(NSString *)name withData:(NSDictionary *)data
{
  // fetch VCs from registry
  ViewRegistry *registry = [ViewRegistry sharedViewRegistry];
  RootViewController *rootVC = [registry rootControllerForName:name];
  DetailViewController *detailVC = [registry detailControllerForName:name];

  // hook them
  rootVC.detailView = detailVC;
  self.splitViewController.delegate = detailVC;

  // configure with data
  [rootVC configure:data];

  // configur SplitController's UINavigationController
  [[self.splitViewController.viewControllers objectAtIndex:0]
                                        pushViewController:rootVC
                                                  animated:YES];

  [[self.splitViewController.viewControllers objectAtIndex:1]
                                        pushViewController:detailVC
                                                  animated:YES];

}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];

  [splitViewController release];
  [window release];
  [super dealloc];
}


@end
// vim: set ts=2 sw=2 expandtab:

