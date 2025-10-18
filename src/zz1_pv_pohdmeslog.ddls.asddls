@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'MES工單拋轉LOG Projection View'
@UI: {
     headerInfo: {
                typeName: '工單表頭',
                typeNamePlural: '工單表頭'
     }
}
@UI.presentationVariant: [
  {
    qualifier: 'Header',
    visualizations: [{type: #AS_LINEITEM }]
  }
]
@UI.selectionVariant: [
  {
    text: 'Header',
    qualifier: 'Header'
  }
]
define root view entity ZZ1_PV_POHDMESLOG 
    provider contract transactional_query as projection on ZZ1_I_POHDMESLOG
{
        @UI.facet: [
                       { id:            'ALL',
                         purpose:         #STANDARD,
                         type:            #COLLECTION,
                         label:           '資料',
                         position:        10
                       }
                    ]
                    
        @UI: {
                 lineItem: [{ position: 10, importance: #HIGH }]
               }
        @EndUserText.label: '拋轉類型'
    key api_type,
    
        @UI: {
                 lineItem: [{ position: 20, importance: #HIGH }]
               }
        @EndUserText.label: '物件值'
    key objectid,
    
        @UI: {
                 lineItem: [{ position: 30, importance: #HIGH }]
               }
        @EndUserText.label: '序號'
    key serial_no,
    
        @UI: {
                 lineItem: [{ position: 40, importance: #HIGH }],
                 selectionField: [{ position: 40 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductionOrderStdVH', element: 'ProductionOrder' } } ]
        @EndUserText.label: '工單號碼'
        @Search.defaultSearchElement: true       
        aufnr,
        
        @UI: {
                 lineItem: [{ position: 50, importance: #HIGH }],
                 selectionField: [{ position: 50 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_OrderTypeVH', element: 'OrderType' } } ]
        @EndUserText.label: '工單類型'
        auart,
        
        @UI: {
                 lineItem: [{ position: 60, importance: #HIGH }],
                 selectionField: [{ position: 60 }]
               }
        @EndUserText.label: '料號'
        matnr,
        
        @UI: {
                 lineItem: [{ position: 70, importance: #HIGH }]
               }
        @EndUserText.label: '目標產量'
        qty,
        
        @UI: {
                 lineItem: [{ position: 80, importance: #HIGH }],
                 selectionField: [{ position: 80 }]
               }
        @EndUserText.label: '工單目前狀態'
        aufnr_status,
        
        @UI: {
                 lineItem: [{ position: 90, importance: #HIGH }],
                 selectionField: [{ position: 90 }]
               }
        @EndUserText.label: '上階工單'
        aufnr_up,
        
        @UI: {
                 lineItem: [{ position: 100, importance: #HIGH }],
                 selectionField: [{ position: 100 }]
               }
        @EndUserText.label: '主要工單'
        aufnr_main,
        
        @UI: {
                 lineItem: [{ position: 110, importance: #HIGH }],
                 selectionField: [{ position: 110 }]
               }
        @EndUserText.label: '主要料號'
        matnr_main,
        
        @UI: {
                 lineItem: [{ position: 115, importance: #HIGH }],
                 selectionField: [{ position: 115 }]
               }
        @EndUserText.label: '工單批次號碼'
        charg,
        
        @UI: {
                 lineItem: [{ position: 120, importance: #HIGH }],
                 selectionField: [{ position: 120 }]
               }
        @EndUserText.label: '資料狀態'
        data_status,
        
        @UI: {
                 selectionField: [{ position: 130 }]
               }
        @EndUserText.label: '發料類型'
        wo_pick_type,
        
        @EndUserText.label: '預留單號'
//        @UI.hidden: true
        reservation,
        
        @EndUserText.label: '預留單項次'
//        @UI.hidden: true
        reservation_item,
        
        @UI: {
                 selectionField: [{ position: 160 }]
               }
        @EndUserText.label: '元件編號'
//        @UI.hidden: true
        item_part_no,
        
        @EndUserText.label: '替代群組'
//        @UI.hidden: true
        item_group,
        
        @EndUserText.label: '主替標示'
//        @UI.hidden: true
        item_group_index,
        
        @EndUserText.label: '發料儲存位置'
//        @UI.hidden: true
        warehouse_no,
        
        @UI: {
                 selectionField: [{ position: 200 }]
               }
        @EndUserText.label: '工廠'
//        @UI.hidden: true
        factory,
        
        @UI: {
                 selectionField: [{ position: 210 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_GoodsMovementTypeT', element: 'GoodsMovementType' } } ]    
        @EndUserText.label: 'MVT'
//        @UI.hidden: true
        movetype,
        
        @UI: {
                 selectionField: [{ position: 220 }]
               }
        @EndUserText.label: '類型'
//        @UI.hidden: true
        type,   
        
        @UI: {
                 lineItem: [{ position: 130, importance: #HIGH }],
                 selectionField: [{ position: 230 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_User', element: 'UserID' } } ]    
        @EndUserText.label: '建立者'
        ernam,
        
        @UI: {
                 lineItem: [{ position: 140, importance: #HIGH }],
                 selectionField: [{ position: 240 }]
               }
        @EndUserText.label: '建立日期'
        erdat,
        
        @UI: {
                 lineItem: [{ position: 150, importance: #HIGH }]
               }
        @EndUserText.label: '建立時間'
        erfzeit,
        
        @UI: {
                 lineItem: [{ position: 160, importance: #HIGH }],
                 selectionField: [{ position: 260 }]
               }
        @EndUserText.label: '拋轉狀態'
        status,
        
        @UI: {
                 lineItem: [{ position: 170, importance: #HIGH }],
                 selectionField: [{ position: 270 }]
               }
        @EndUserText.label: '訊息'
        message
} where api_type = 'HEADER'

    
