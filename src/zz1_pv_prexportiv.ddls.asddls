@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '匯出供應商發票'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #L,
    dataClass: #MIXED
}
@UI: {
     headerInfo: {
                typeName: '匯出供應商發票',
                typeNamePlural: '匯出供應商發票'
     },
     presentationVariant: [{        
        visualizations: [{
            type: #AS_LINEITEM
        }]
    }]
     
}
define root  view entity ZZ1_PV_PREXPORTIV

 as projection on ZZ1_I_PREXPORTIV 

{
//    @UI: {
//           lineItem: [{ position: 60 }],
//           selectionField: [{ position: 10}]        
//       }
//    @EndUserText.label: '文件日期'      
//    key YY1_TW_GUINO_DATE_PRI,    
    @UI: {
           lineItem: [{ position: 1140  }]  ,
           selectionField: [{ position: 1}]         
       }
    @EndUserText.label: '請購單號'   
    key PurchaseRequisition,
    @UI: {
           lineItem: [{ position: 1150  }]        
       }
    @EndUserText.label: '請購單號項目'       
    key PurchaseRequisitionItem,
    key PurchaseReqnAcctAssgmtNumber,
    @UI: {
           lineItem: [{ position: 21  }]      
       }
    @EndUserText.label: '成本中心'      
    key CostCenter,      
    @UI: {
           selectionField: [{ position: 20}]        
       }
    @EndUserText.label: '採購群組'      
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PurchasingGroup', element: 'PurchasingGroup' } }] 
    PurchasingGroup,
    @UI: {
           lineItem: [{ position: 50  }],
           selectionField: [{ position: 30}]        
       }
    @EndUserText.label: '開票方'          
    Supplier, //期望供應商
    @UI: {
           lineItem: [{ position:60  }]      
       }
    @EndUserText.label: '參考'       
    YY1_TW_GUINO_PR_PRI,
    @UI: {
           lineItem: [{ position: 70 }],
           selectionField: [{ position: 10}]        
       }
    @EndUserText.label: '文件日期'      
    YY1_TW_GUINO_DATE_PRI,
    @UI: {
           lineItem: [{ position: 110   }]      
       }
    @EndUserText.label: '幣別'       
    PurReqnItemCurrency,
    @UI: {
           lineItem: [{ position: 120  }]      
       }
    @EndUserText.label: '發票毛額'       
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    ItemNetAmount,
    
    @UI: {
           lineItem: [{ position: 720  }]      
       }
    @EndUserText.label: '科目'      
    GLAccount,
    @UI: {
           lineItem: [{ position: 730  }]      
       }
    @EndUserText.label: '項目內文'      
    text1,
    @UI: {
           lineItem: [{ position: 740  }]      
       }
    @EndUserText.label: '借/貸方指示碼'      
    hkont,
    @UI: {
           lineItem: [{ position: 20  }]      
       }
    @EndUserText.label: '金額(文件幣別)'      
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    amount,  
    @UI: {
           lineItem: [{ position: 760  }]      
       }
    @EndUserText.label: '稅碼'      
    TaxCode, //稅碼
    @UI: {
           lineItem: [{ position: 780  }]      
       }
    @EndUserText.label: '指派'      
    guino,
//    @UI: {
//           lineItem: [{ position: 790  }]      
//       }
//    @EndUserText.label: '成本中心'      
//    CostCenter,    
    @UI: {
           lineItem: [{ position: 820  }]      
       }
    @EndUserText.label: 'WBS元素'      
    wbselement   ,
    @UI: {
           lineItem: [{ position: 980  }]      
       }
    @EndUserText.label: '文件貨幣計的稅基金額'    
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    YY1_TAX_BASE_PRI,
    @UI: {
           lineItem: [{ position:10  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'   
    @EndUserText.label: '發票ID'       
    id, 
//    @UI: {
//           lineItem: [{ position:1160  }]      
//       }    
//    @EndUserText.label: '筆數'     
    YY1_COUNT_PRI,
    @UI: {
           lineItem: [{ position: 30  }]      
       }
    @EndUserText.label: '公司代碼'       
    bukrs1,
    @UI: {
           lineItem: [{ position:40   }]      
       }
    @EndUserText.label: '交易'       
    trade,
    @UI: {
           lineItem: [{ position: 80  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    @EndUserText.label: '過帳日期'       
    budat1,
    @UI: {
           lineItem: [{ position: 90  }]      
       }
    @EndUserText.label: '文件類型'       
    doctype1,
    @UI: {
           lineItem: [{ position: 100  }]      
       }
    @EndUserText.label: '文件表頭內文'       
    docheadtext,
    @UI: {
           lineItem: [{ position: 130  }]      
       }
    @EndUserText.label: '營業處'       
    bupla,
    @UI: {
           lineItem: [{ position: 140  }]      
       }
    @EndUserText.label: '付款凍結碼'       
    payfrozen,
    @UI: {
           lineItem: [{ position: 150  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    @EndUserText.label: '到期日計算的基準日期'       
    date1,
    @UI: {
           lineItem: [{ position: 155  }]      
       }
    @EndUserText.label: '現金折扣金額'       
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'     
    amount1,
    @UI: {
           lineItem: [{ position: 160  }]      
       }
    @EndUserText.label: '付款方法'       
    paymethod1,
    @UI: {
           lineItem: [{ position: 170  }]      
       }
    @EndUserText.label: '付款方法補充'       
    paymethod2,
    @UI: {
           lineItem: [{ position: 180   }]      
       }
    @EndUserText.label: '付款參考'       
    paymethod3,
    @UI: {
           lineItem: [{ position: 190  }]      
       }
    @EndUserText.label: '發票參考:發票參考文件號碼'       
    xblnr1,
    @UI: {
           lineItem: [{ position: 200   }]      
       }
    @EndUserText.label: '有關發票的會計年度'       
    xblnr2,
    @UI: {
           lineItem: [{ position: 210   }]      
       }
    @EndUserText.label: '付款條件碼'       
    paymethod4,
    @UI: {
           lineItem: [{ position: 220  }]      
       }
    @EndUserText.label: '現金折扣天數 1'       
    payday1,
    @UI: {
           lineItem: [{ position: 230  }]      
       }
    @EndUserText.label: '現金折扣百分比 1'       
    paydiscount1,
    @UI: {
           lineItem: [{ position: 240   }]      
       }
    @EndUserText.label: '現在折扣天數 2'       
    payday2,
    @UI: {
           lineItem: [{ position: 250  }]      
       }
    @EndUserText.label: '現金折扣百分比 2'       
    paydiscount2,
    @UI: {
           lineItem: [{ position: 260  }]      
       }
    @EndUserText.label: '淨付款條件期間'       
    paytime,
    @UI: {
           lineItem: [{ position: 270  }]      
       }
    @EndUserText.label: '固定付款條件'       
    paycondition,
    @UI: {
           lineItem: [{ position: 280  }]      
       }
    @EndUserText.label: '未計劃的交貨成本'       
    deliverycost,
    @UI: {
           lineItem: [{ position: 290  }]      
       }
    @EndUserText.label: '稅碼'       
    taxcode2,
    @UI: {
           lineItem: [{ position: 300  }]      
       }
    @EndUserText.label: '租稅管轄權'       
    rent1,
    @UI: {
           lineItem: [{ position: 310  }]      
       }
    @EndUserText.label: '參考文件種類'       
    refdoctype,
    @UI: {
           lineItem: [{ position: 320  }]      
       }
    @EndUserText.label: '指派號碼'       
    number1,
    @UI: {
           lineItem: [{ position: 330  }]      
       }
    @EndUserText.label: '項目內文'       
    text2 ,
    @UI: {
           lineItem: [{ position: 340  }]      
       }
    @EndUserText.label: '區段代碼'       
    code ,
    @UI: {
           lineItem: [{ position: 350  }]      
       }
    @EndUserText.label: 'ISR訂戶號碼'       
    isruser,
    @UI: {
           lineItem: [{ position: 360  }]      
       }
    @EndUserText.label: 'POR檢核碼'       
    porcode,
    @UI: {
           lineItem: [{ position: 370  }]      
       }
    @EndUserText.label: '有參考號碼的付款委託書/QR參考號碼'       
    xblnr3,
    @UI: {
           lineItem: [{ position: 380  }]      
       }
    @EndUserText.label: '業務範圍'       
    range,
    @UI: {
           lineItem: [{ position: 390  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'   
    @EndUserText.label: '發票接收日期'       
    budat2,
    @UI: {
           lineItem: [{ position: 400  }]      
       }
    @EndUserText.label: '於歐盟內交貨的申報國家/地區'      
    country1,
    @UI: {
           lineItem: [{ position: 410  }]      
       }
    @EndUserText.label: '指示碼:歐盟內的三角交易'       
    tritrade,
    @UI: {
           lineItem: [{ position: 420  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'   
    @EndUserText.label: '定義稅率日期'       
    budat3,
    @UI: {
           lineItem: [{ position: 430  }]      
       }
    @EndUserText.label: '往來銀行的簡短鍵值'       
    keypoint,
    @UI: {
           lineItem: [{ position: 440  }]      
       }
    @EndUserText.label: '帳戶明細ID'       
    accid,
    @UI: {
           lineItem: [{ position: 450  }]      
       }
    @EndUserText.label: '納稅申報國家/地區'       
    country2,
    @UI: {
           lineItem: [{ position: 460  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 1'       
    country3,
    @UI: {
           lineItem: [{ position: 470   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 1'       
    countrydate1,
    @UI: {
           lineItem: [{ position: 480  }]      
       }
    @EndUserText.label: '合作銀行類型'       
    cobank,
    @UI: {
           lineItem: [{ position: 490  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    @EndUserText.label: '納稅申報日期'       
    budat4,
    @UI: {
           lineItem: [{ position: 500  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'
    @EndUserText.label: '稅務執行日期'       
    budat5,
    @UI: {
           lineItem: [{ position: 510  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定業務夥伴 1'       
    countrypart1,
    @UI: {
           lineItem: [{ position: 520  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定業務夥伴 2'       
    countrypart2,
    @UI: {
           lineItem: [{ position: 530   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 2'      
    countrydate2,
    @UI: {
           lineItem: [{ position: 540   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 3'      
    countrydate3,
    @UI: {
           lineItem: [{ position: 550   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 4'      
    countrydate4,
    @UI: {
           lineItem: [{ position: 560   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 5'      
    countrydate5,
    @UI: {
           lineItem: [{ position: 570  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 2'      
    country4,
    @UI: {
           lineItem: [{ position: 580  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 3'      
    country5,
    @UI: {
           lineItem: [{ position: 590  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 4'      
    country6,
    @UI: {
           lineItem: [{ position: 600  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 5'      
    country7,
    @UI: {
           lineItem: [{ position: 610  }]      
       }
    @EndUserText.label: 'IBAN(國際銀行帳號)'       
    ibanacc,
    @UI: {
           lineItem: [{ position: 620  }]      
       }
    @EndUserText.label: '零星科目資料中的國家/地區特定參考'      
    country8,
    @UI: {
           lineItem: [{ position: 630  }]      
       }
    @EndUserText.label: '付款原因'      
    payreason,
    @UI: {
           lineItem: [{ position: 640  }]      
       }
    @EndUserText.label: '發票頁數'      
    ivopage,
    @UI: {
           lineItem: [{ position: 650  }]      
       }
    @EndUserText.label: '供應國家/地區'      
    country9,
    @UI: {
           lineItem: [{ position: 660  }]      
       }
    @EndUserText.label: '中央銀行指示碼'      
    centralbank,
    @UI: {
           lineItem: [{ position: 661  }]      
       }
    @EndUserText.label: '調節科目'      
    adjust,    
    @UI: {
           lineItem: [{ position: 670  }]      
       }
    @EndUserText.label: '後勤發票驗證文件的來源'      
    ivosource,
    @UI: {
           lineItem: [{ position: 680  }]      
       }
    @EndUserText.label: '業務網路文件的來源'      
    docsource,
    @UI: {
           lineItem: [{ position: 690  }]      
       }
    @EndUserText.label: '發票上傳UUID'      
    uuid,
    @UI: {
           lineItem: [{ position: 700  }]      
       }
    @EndUserText.label: '上傳的發票來源'      
    upivosource,
    @UI: {
           lineItem: [{ position: 710  }]      
       }
    @EndUserText.label: '公司代碼'      
    bukrs2,
    @UI: {
           lineItem: [{ position: 770  }]      
       }
    @EndUserText.label: '租稅管轄權'      
    rent2,
    @UI: {
           lineItem: [{ position: 800  }]      
       }
    @EndUserText.label: '利潤中心'      
    kostl,
    @UI: {
           lineItem: [{ position: 810  }]      
       }
    @EndUserText.label: '訂單號碼'      
    vbeln1,
    @UI: {
           lineItem: [{ position: 830  }]      
       }
    @EndUserText.label: '業務範圍'      
    busrange,
    @UI: {
           lineItem: [{ position: 840  }]      
       }
    @EndUserText.label: '企業流程'      
    busprocess,
    @UI: {
           lineItem: [{ position: 850  }]      
       }
    @EndUserText.label: '成本控制範圍'      
    costcontrol,
    @UI: {
           lineItem: [{ position: 860  }]      
       }
    @EndUserText.label: '作業類型'      
    worktype,
    @UI: {
           lineItem: [{ position: 870  }]      
       }
    @EndUserText.label: '成本物件'      
    costelement,
    @UI: {
           lineItem: [{ position: 880  }]      
       }
    @EndUserText.label: '功能範圍'      
    funcrange,
    @UI: {
           lineItem: [{ position: 890  }]      
       }
    @EndUserText.label: '沒有現金折扣'      
    nondiscount,
    @UI: {
           lineItem: [{ position: 900  }]      
       }
    @EndUserText.label: '員工號碼'      
    employeenum,
    @UI: {
           lineItem: [{ position: 910  }]      
       }
    @EndUserText.label: '銷售訂單號碼'      
    vbeln2,
    @UI: {
           lineItem: [{ position: 920  }]      
       }
    @EndUserText.label: '銷售訂單項目'   
    posnr,
    @UI: {
           lineItem: [{ position: 930  }]      
       }
    @EndUserText.label: '科目指派網狀圖號碼'    
    number2,
    @UI: {
           lineItem: [{ position: 940  }]      
       }
    @EndUserText.label: '作業號碼'    
    vornr,
    @UI: {
           lineItem: [{ position: 950  }]      
       }
    @EndUserText.label: '工作項目ID'    
    workid,
    @UI: {
           lineItem: [{ position: 960  }]      
       }
    @EndUserText.label: '承約項目'    
    item,
    @UI: {
           lineItem: [{ position: 970  }]      
       }
    @EndUserText.label: '基金中心'    
    foundcenter,
    @UI: {
           lineItem: [{ position: 990   }]      
       }
    @EndUserText.label: '基金'    
    founder,
    @UI: {
           lineItem: [{ position: 1000   }]      
       }
    @EndUserText.label: '贊助金'    
    donate,
    @UI: {
           lineItem: [{ position: 1010   }]      
       }
    @EndUserText.label: '基礎計量單位'    
    unit,
    @UI: {
           lineItem: [{ position: 1020  }]      
       }
    @EndUserText.label: '數量'    
    kwmeng,
    @UI: {
           lineItem: [{ position: 1030   }]      
       }
    @EndUserText.label: '夥伴業務範圍'    
    partrange,
    @UI: {
           lineItem: [{ position: 1040   }]      
       }
    @EndUserText.label: '服務文件類型'    
    servtype,
    @UI: {
           lineItem: [{ position: 1050  }]      
       }
    @EndUserText.label: '服務文件ID'    
    servdocid,
    @UI: {
           lineItem: [{ position: 1060  }]      
       }
    @EndUserText.label: '服務文件項目ID'    
    servitemid,
    @UI: {
           lineItem: [{ position: 1070  }]      
       }
    @EndUserText.label: '納稅申報國家/地區'    
    country10,
    @UI: {
           lineItem: [{ position: 1080  }]      
       }
    @EndUserText.label: '交易類型'    
    tradetype,
    @UI: {
           lineItem: [{ position: 1090  }]      
       }
    @EndUserText.label: '預算期間'    
    budgetperiod,
    @UI: {
           lineItem: [{ position: 1100  }]      
       }
    @EndUserText.label: '已指定用途基金的文件號碼'    
    founddocnum,
    @UI: {
           lineItem: [{ position: 1110  }]      
       }
    @EndUserText.label: '已指定用途的基金:文件項目'    
    founddocitem,
    @UI: {
           lineItem: [{ position: 1120  }]      
       }
    @EndUserText.label: '明細項目的完成指示碼'    
    docfinish,
    @UI: {
           lineItem: [{ position: 1130  }]      
       }
    @EndUserText.label: '復原指示碼'    
    recover,
    
    @UI: {
           lineItem: [{ position: 1131  }]      
       }
    @EndUserText.label: '客戶代號'    
    customer,
    
    @UI: {
           lineItem: [{ position: 1132  }]      
       }
    @EndUserText.label: '客戶名稱'    
    customername,
    
//    PurchaseReqnAcctAssgmtNumber,
    @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
    PurchaseRequisitionPrice,   
    MultipleAcctAssgmtDistrPercent       
} 
