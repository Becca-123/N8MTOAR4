@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: '線邊倉發料拋轉MES LOG Projection View'
@UI: {
     headerInfo: {
                typeName: '線邊倉發料',
                typeNamePlural: '線邊倉發料'
     }
}
@UI.presentationVariant: [
  {
    qualifier: 'Componentmes',
    visualizations: [{type: #AS_LINEITEM }]
  }
]
@UI.selectionVariant: [
  {
    text: '線邊倉發料',
    qualifier: 'Mocomponent'
  }
]
define root view entity ZZ1_PV_MOCOMPONENTLOG
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
                 selectionField: [{ position: 60 }]
               }
        @EndUserText.label: '工單表頭生產物料'
        matnr,
        
        @UI: {
                 lineItem: [{ position: 51, importance: #HIGH }],
                 selectionField: [{ position: 130 }]
               }
        @EndUserText.label: '發料類型'
        wo_pick_type,
        
        @UI: {
                 lineItem: [{ position: 60, importance: #HIGH }],
                 selectionField: [{ position: 120 }]
               }
        @EndUserText.label: '資料狀態'
        data_status,
        
        @UI: {
                 lineItem: [{ position: 70, importance: #HIGH }]
               }
        @EndUserText.label: '預留單號'
        reservation,
        
        @UI: {
                 lineItem: [{ position: 80, importance: #HIGH }]
               }
        @EndUserText.label: '預留單項次'
        reservation_item,
        
        @UI: {
                 lineItem: [{ position: 90, importance: #HIGH }],
                 selectionField: [{ position: 160 }]
               }
        @EndUserText.label: '元件編號'
        item_part_no,
        
        @UI: {
                 lineItem: [{ position: 100, importance: #HIGH }]
               }
        @EndUserText.label: '替代群組'
        item_group,
        
        @UI: {
                 lineItem: [{ position: 110, importance: #HIGH }]
               }
        @EndUserText.label: '主替標示'
        item_group_index,

        @UI: {
                 lineItem: [{ position: 120, importance: #HIGH }]
               }
        @EndUserText.label: '元件數量'
        qty,
        
        @UI: {
                 lineItem: [{ position: 130, importance: #HIGH }]
               }
        @EndUserText.label: '發料儲存位置'
        warehouse_no,
        
        @UI: {
                 lineItem: [{ position: 140, importance: #HIGH }],
                 selectionField: [{ position: 200 }]
               }
        @EndUserText.label: '工廠'
        factory,
        
        @UI: {
                 lineItem: [{ position: 150, importance: #HIGH }],
                 selectionField: [{ position: 210 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_GoodsMovementTypeT', element: 'GoodsMovementType' } } ]    
        @EndUserText.label: 'MVT'
        movetype,
        
        @UI: {
                 lineItem: [{ position: 160, importance: #HIGH }],
                 selectionField: [{ position: 220 }]
               }
        @EndUserText.label: '類型'
        type,   
        
        @UI: {
                 selectionField: [{ position: 50 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_OrderTypeVH', element: 'OrderType' } } ]
        @EndUserText.label: '工單類型'
//        @UI.hidden: true
        auart,
        
        @UI: {
                 selectionField: [{ position: 80 }]
               }
        @EndUserText.label: '工單目前狀態'
//        @UI.hidden: true
        aufnr_status,
        
        @UI: {
                 selectionField: [{ position: 90 }]
               }
        @EndUserText.label: '上階工單'
//        @UI.hidden: true
        aufnr_up,
        
        @UI: {
                 selectionField: [{ position: 100 }]
               }
        @EndUserText.label: '主要工單'
//        @UI.hidden: true
        aufnr_main,
        
        @UI: {
                 selectionField: [{ position: 110 }]
               }
        @EndUserText.label: '主要料號'
//        @UI.hidden: true
        matnr_main,
        
        @UI: {
                 selectionField: [{ position: 115 }]
               }
        @EndUserText.label: '工單批次號碼'
//        @UI.hidden: true
        charg,
        
        @UI: {
                 lineItem: [{ position: 170, importance: #HIGH }],
                 selectionField: [{ position: 230 }]
               }
        @EndUserText.label: '建立者'
        ernam,
        
        @UI: {
                 lineItem: [{ position: 180, importance: #HIGH }],
                 selectionField: [{ position: 240 }]
               }
        @Consumption.valueHelpDefinition: [ { entity: { name: 'I_User', element: 'UserID' } } ]    
        @EndUserText.label: '建立日期'
        erdat,
        
        @UI: {
                 lineItem: [{ position: 190, importance: #HIGH }]
               }
        @EndUserText.label: '建立時間'
        erfzeit,
        
        @UI: {
                 lineItem: [{ position: 200, importance: #HIGH }],
                 selectionField: [{ position: 260 }]
               }
        @EndUserText.label: '拋轉狀態'
        status,
        
        @UI: {
                 lineItem: [{ position: 210, importance: #HIGH }],
                 selectionField: [{ position: 270 }]
               }
        @EndUserText.label: '訊息'
        message
} where api_type = 'MOCOMPONENT'

    
