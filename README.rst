=================================
Multi Split View & Windchill Demo
============================

:Author:    Stefan Eletzhofer
:Date:      2011-03-17
:Revision:  0.1dev

Abstract
========

This project tries to demo:

- using a UISPlitView and a UITableView Detail View Controller together for
  hierarchical navigation e.g. drilling down using the Detail View causes the
  **Root View Controller** of the UISplitView to change

- Connecting to a JSON based Web Service (here: Windchill, which is totally
  unrelated but I need it for a demo ...)

Todo
====

- use ASIHTTP Framework to load/fetch data

- use NSNotifications to inform about async data and cause a reload

- maybe gut the Image Cache from BFever and import it here

Data URLs
=========

(see http://curl.haxx.se/docs/httpscripting.html)

Test JSP (to test authentication)::

    $ curl --user wcadmin:wcadmin  http://wc.nexiles.com/Windchill/netmarkets/jsp/nexiles/test.jsp
    ...
    #-------------------------------------------------
    #Products in Org
    name: GOLF_CART oid: wt.pdmlink.PDMLinkProduct:33227
    name: Drive System oid: wt.pdmlink.PDMLinkProduct:35696
    name: ProductView Demo oid: wt.pdmlink.PDMLinkProduct:84774
    name: GENERIC_COMPUTER oid: wt.pdmlink.PDMLinkProduct:87805
    name: Power System oid: wt.pdmlink.PDMLinkProduct:88255
    name: Bicycle2 oid: wt.pdmlink.PDMLinkProduct:89532
    #-------------------------------------------------
  

Organization Data::

    $ curl -s --user wcadmin:wcadmin  'wc.nexiles.com/Windchill/netmarkets/jsp/nexiles/json.jsp?m=list&f=get_organizations' | python -mjson.tool
    {
        "organizations": [
            {
                "name": "Nexiles", 
                "oid": "OR:wt.inf.container.OrgContainer:30857", 
                "products": []
            }, 
            {
                "name": "Demo Organization", 
                "oid": "OR:wt.inf.container.OrgContainer:33077", 
                "products": [
                    {
                        "name": "GOLF_CART", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:33227"
                    }, 
                    {
                        "name": "Drive System", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:35696"
                    }, 
                    {
                        "name": "ProductView Demo", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:84774"
                    }, 
                    {
                        "name": "GENERIC_COMPUTER", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:87805"
                    }, 
                    {
                        "name": "Power System", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:88255"
                    }, 
                    {
                        "name": "Bicycle2", 
                        "oid": "OR:wt.pdmlink.PDMLinkProduct:89532"
                    }
                ]
            }
        ]
    }

Product listing::

    $ curl -s --user wcadmin:wcadmin  'http://wc.nexiles.com/Windchill/netmarkets/jsp/nexiles/json.jsp?m=list&f=get_product&oid=OR:wt.pdmlink.PDMLinkProduct:35696' | python -mjson.tool
    {
        "epm_documents": [
           ...,
            {
                "cadname": "sqb018.prt", 
                "name": "sqb018.prt", 
                "number": "SQB018.PRT", 
                "oid": "OR:wt.epm.EPMDocument:38823", 
                "version": "A.1"
            }
        ], 
        "name": "Drive System", 
        "oid": "OR:wt.pdmlink.PDMLinkProduct:35696"
     }


Document info::

    $ curl -s --user wcadmin:wcadmin  'http://wc.nexiles.com/Windchill/netmarkets/jsp/nexiles/json.jsp?m=list&f=get_epm_document&oid=OR:wt.epm.EPMDocument:46499' | python -mjson.tool
    {
        "oid": "OR:wt.epm.EPMDocument:46499", 
        "name": "01-32000.asm", 
        "number": "01-32000.ASM", 
        "cadname": "01-32000.asm", 
        "state": "INWORK", 
        "version": "A.1"
        "doctype": "CADASSEMBLY", 
        "folder_path": "/Default/01-32000.asm", 
        "isDerived": false, 
        "isExtentsValid": false, 
        "isGeneric": false, 
        "isHasContents": false, 
        "isHasHangingChange": false, 
        "isHasPendingChange": false, 
        "isHasVariance": false, 
        "isInheritedDomain": true, 
        "isInstance": false, 
        "isLatestIteration": true, 
        "isLifeCycleAtGate": false, 
        "isLifeCycleBasic": true, 
        "isLocked": false, 
        "isMissingDependents": false, 
        "isPlaceHolder": false, 
        "isTemplated": false, 
        "isTopGeneric": false, 
        "isVerified": true, 
        "creator": {
            "email": "", 
            "fullname": "wcadmin", 
            "name": "Administrator", 
            "oid": "OR:wt.org.WTUser:10"
        }, 
        "modifier": {
            "email": "", 
            "fullname": "wcadmin", 
            "name": "Administrator", 
            "oid": "OR:wt.org.WTUser:10"
        }, 
        "parameters": {}, 
        "attributes": {}, 
        "used_by": [
            {
                "attributes": {}, 
                "hasIBAValues": false, 
                "oid": "OR:wt.epm.structure.EPMReferenceLink:83165", 
                "reference_type": "RELATION", 
                "referenced_by": {
                    "cadname": "01-32150.prt", 
                    "name": "01-32150.prt", 
                    "number": "01-32150.PRT", 
                    "oid": "OR:wt.epm.EPMDocument:37086", 
                    "version": "A.1"
                }, 
                "references": "OR:wt.epm.EPMDocumentMaster:46495", 
                "type": "EPM Document Reference Link"
            }, 
            {
                "attributes": {}, 
                "hasIBAValues": false, 
                "oid": "OR:wt.epm.structure.EPMReferenceLink:84280", 
                "reference_type": "RELATION", 
                "referenced_by": {
                    "cadname": "01-32160.prt", 
                    "name": "01-32160.prt", 
                    "number": "01-32160.PRT", 
                    "oid": "OR:wt.epm.EPMDocument:41158", 
                    "version": "A.1"
                }, 
                "references": "OR:wt.epm.EPMDocumentMaster:46495", 
                "type": "EPM Document Reference Link"
            }
        ]
    }



Changelog
=========

0.1 - ????-??-??
----------------

- begun Readme and Changelog


::

 vim: set ft=rst tw=75 nocin nosi ai sw=4 ts=4 expandtab:
