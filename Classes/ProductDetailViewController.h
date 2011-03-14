//
//  ProductDetailViewController.h
//  MultiSplitView
//
//  Created by Stephan Eletzhofer on 11.03.11.
//  Copyright 2011 Nexiles GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseDetailViewController.h"

@interface ProductDetailViewController : BaseDetailViewController {
  NSArray      * _EPMDocuments;
  NSString     * _name;
  NSString     * _oid;
  NSString     * _owner;
}

@property (nonatomic, retain) NSString     * name;
@property (nonatomic, retain) NSString     * oid;
@property (nonatomic, retain) NSString     * owner;
@property (nonatomic, retain) NSArray      * EPMDocuments;

-(void)configure;

@end
// vim: set ts=2 sw=2 expandtab:
