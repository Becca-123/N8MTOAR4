@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: '請款單列印Projection View'
@Search.searchable: true

@UI: {
     headerInfo: {
                typeName: '請款單列印',
                typeNamePlural: '請款單列印'
     },
     presentationVariant: [{        
        visualizations: [{
            type: #AS_LINEITEM
        }]
    }]
     
}
define root view entity ZZ1_PV_PURCHASEREQ as projection on ZZ1_I_PURCHASEREQ
{
 @UI.facet: [
                 { id:            'ALL',
                   purpose:        #STANDARD,
                   type:           #COLLECTION,
                   label:          '資料',
                   position:       10
                 }
             ]
  @UI: {
         lineItem: [{ position: 10, importance: #HIGH  }],
         selectionField: [{ position: 50}]
       }
  @Search.defaultSearchElement: true
  @EndUserText.label: '請購單號'         
  key   PurchaseRequisition, 
  @UI: {
         lineItem: [{ position: 20, importance: #HIGH  }]        
       }
  @EndUserText.label: '請購單號項目'         
  key   PurchaseRequisitionItem, 
  key PurchaseReqnAcctAssgmtNumber,
  @UI: {
         lineItem: [{ position: 100, importance: #HIGH  }]  ,
         selectionField: [{ position: 40}]        
       }
  @EndUserText.label: '成本中心'    
  key CostCenter,  
  @UI: {
         lineItem: [{ position: 30, importance: #HIGH  }] , 
         selectionField: [{ position: 30}]       
       }
  @EndUserText.label: '建立者'     
  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_User', element: 'bname' } } ]    
  CreatedByUser, 
  @UI: {
         lineItem: [{ position: 40, importance: #HIGH  }]        
       }
  @EndUserText.label: '建立者姓名'     
  name, 
  @UI: {
         lineItem: [{ position: 50, importance: #HIGH  }]  ,
         selectionField: [{ position: 10}]        
       }
  @EndUserText.label: '文件日期'    
  PurchaseReqnCreationDate, 
  @UI: {
         lineItem: [{ position: 60, importance: #HIGH  }]        
       }
  @EndUserText.label: '短文'    
  PurchaseRequisitionItemText,
//  @UI: {
//         lineItem: [{ position: 70, importance: #HIGH  }]        
//       }
//  @EndUserText.label: '物料群組'    
//  MaterialGroup,
  @UI: {
         lineItem: [{ position: 80, importance: #HIGH  }]        
       }
  @EndUserText.label: '物料群組名稱'    
  ProductGroupName,
  @UI: {
         lineItem: [{ position: 90, importance: #HIGH  }] ,
         selectionField: [{ position: 20}]         
       }
  @EndUserText.label: '簽核狀態'    
  PurchaseRequisitionStatus,
//  @UI: {
//         lineItem: [{ position: 100, importance: #HIGH  }]  ,
//         selectionField: [{ position: 40}]        
//       }
//  @EndUserText.label: '成本中心'    
//  CostCenter,
  @UI: {
         lineItem: [{ position: 110, importance: #HIGH  }]        
       }
  @EndUserText.label: '案名'    
  YY1_CASE_NAME_PRI,
  @UI: {
         lineItem: [{ position: 120, importance: #HIGH  }]        
       }
  @EndUserText.label: '案號'    
  YY1_CASE_NUMBER_PRI,  
  @UI: {
         lineItem: [{ position: 130, importance: #HIGH  }]        
       }
  @EndUserText.label: '幣別'    
  PurReqnItemCurrency,
  @UI: {
         lineItem: [{ position: 140, importance: #HIGH  }]        
       }
  @EndUserText.label: '金額'    
  @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
  @DefaultAggregation: #NONE
  PurchaseRequisitionPrice, 
  @UI: {
//         lineItem: [{ position: 40, importance: #HIGH  }]
           selectionField: [{ position: 60}]        
       }
  @EndUserText.label: '採購群組'      
  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchasingGroup', element: 'PurchasingGroup' } }] 
  PurchasingGroup,
  @UI: {
         lineItem: [{ position: 150}]        
       }  
  @EndUserText.label: 'CRM案號'           
  wbselement,
  @UI: {
         lineItem: [{ position: 160}] ,
         selectionField: [{ position: 70}]        
       }  
  @EndUserText.label: '發票號碼'   
  YY1_TW_GUINO_PR_PRI       
}
