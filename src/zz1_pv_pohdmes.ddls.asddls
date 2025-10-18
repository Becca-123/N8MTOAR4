@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.allowExtensions: true
@EndUserText.label: '工單MES拋轉作業 Projection View'
@UI: {
     headerInfo: {
                typeName: '工單MES拋轉作業',
                typeNamePlural: '工單MES拋轉作業'
     }
}
define root view entity ZZ1_PV_POHDMES as projection on ZZ1_I_POHDMES
{
        @UI: {
               lineItem: [{ position: 50, importance: #HIGH }],
               selectionField: [{ position: 30 }]
           }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductionOrderStdVH', element: 'ProductionOrder' } } ]
        @EndUserText.label: '工單號碼'
        @Search.defaultSearchElement: true                
    key ManufacturingOrder,
    
        @UI: {
               lineItem: [{ position: 30, importance: #HIGH }],
               selectionField: [{ position: 10 }]
           }
        @EndUserText.label: '工廠代碼'     
        ProductionPlant,
        
        @UI: {
               lineItem: [{ position: 40, importance: #HIGH }],
               selectionField: [{ position: 20 }]
           }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_OrderTypeVH', element: 'OrderType' } } ]
        @EndUserText.label: '工單類型'     
        ManufacturingOrderType,
        
        @UI: {
               lineItem: [{ position: 60, importance: #HIGH }],
               selectionField: [{ position: 40 }]
           }
        @EndUserText.label: '工單開始日期'     
        MfgOrderPlannedStartDate,
        
        @UI: {
               lineItem: [{ position: 70, importance: #HIGH }],
               selectionField: [{ position: 50 }]
           }
        @EndUserText.label: '工單結束日期'   
        MfgOrderPlannedEndDate,
        
        @UI: {
               lineItem: [{ position: 80, importance: #HIGH }],
               selectionField: [{ position: 60 }]
           }
        @EndUserText.label: '產品'   
        Material,
        
        @UI: {
               lineItem: [{ position: 90, importance: #HIGH }]
           }
        @EndUserText.label: '產品說明'   
        ProductName,
        
        @UI: {
               lineItem: [{ position: 100, importance: #HIGH }]
           }
        @EndUserText.label: '數量'   
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        MfgOrderPlannedTotalQty,
        
        @UI.hidden: true
        ProductionUnit,
        
        @UI: {
               lineItem: [{ position: 110, importance: #HIGH }],
               selectionField: [{ position: 90 }]
           }
        @EndUserText.label: '批次號碼'   
        YY1_PO_CHARG_ORD,

        @UI: {
               lineItem: [{ position: 120, importance: #HIGH }],
               selectionField: [{ position: 100 }]
           }
        @EndUserText.label: 'MES拋轉狀態'   
        YY1_MES_STATUS_ORD,
        
        @UI: {
               lineItem: [{ position: 130, importance: #HIGH }],
               selectionField: [{ position: 110 }]
           }
        @EndUserText.label: '已拋轉過MES'   
        YY1_MES_PO_ORD,
        
        @UI: {
               lineItem: [{ position: 140, importance: #HIGH }],
               selectionField: [{ position: 120 }]
           }
        @EndUserText.label: '發料確認'   
        YY1_MATERIAL_DELIVERY_ORD,
        
        @UI: { lineItem: [{ 
                    type : #FOR_ACTION,
                    dataAction : 'SeandValue',
                    label: '拋轉',
                    position:999, importance: #HIGH }]
              }
        @UI.hidden: true
        sendvalue,
        
        @UI: { lineItem: [{ 
                    type : #FOR_ACTION,
                    dataAction : 'MaterialConfirmation',
                    label: '發料確認',
                    position:998, importance: #HIGH }]
              }
        @UI.hidden: true
        MaterialConfirmation
    
} 
