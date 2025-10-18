@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '匯出供應商發票_匯入'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZZ1_PV_PREXPORTIV_D 
    as projection on ZZ1_I_PREXPORTIV_D

{    
    key iv_uuid,
    @UI: {
           lineItem: [{ position:10 , importance: #HIGH   }]      
       }
    @EndUserText.label: '發票ID'       
    id,        
    @UI: {
           lineItem: [{ position: 750  }]      
       }
    @EndUserText.label: '金額(文件幣別)'      
    @Semantics.amount.currencyCode: 'documentcurrency'
    supplierinvoiceitemamount,   
    @UI: {
           lineItem: [{ position: 790  }]      
       }
    @EndUserText.label: '成本中心'      
    costcenter,      
    @UI: {
           lineItem: [{ position: 20  }]      
       }
    @EndUserText.label: '公司代碼'       
    companycode2,    
    @UI: {
           lineItem: [{ position:30   }]      
       }
    @EndUserText.label: '交易'       
    supplierinvoicetransactiontype,    
    @UI: {
           lineItem: [{ position: 40  }]       
       }
    @EndUserText.label: '開票方'          
    invoicingparty, //期望供應商
    @UI: {
           lineItem: [{ position:50   }]      
       }
    @EndUserText.label: '參考'       
    supplierinvoiceidbyinvcgparty,
    @UI: {
           lineItem: [{ position: 60 }]     
       }
    @EndUserText.label: '文件日期'      
    documentdate,
    @UI: {
           lineItem: [{ position: 70  }]      
       }
    @EndUserText.label: '過帳日期'       
    postingdate,
    @UI: {
           lineItem: [{ position: 80  }]      
       }
    @EndUserText.label: '文件類型'       
    accountingdocumenttype,
    @UI: {
           lineItem: [{ position: 90  }]      
       }
    @EndUserText.label: '文件表頭內文'       
    accountingdocumentheadertext,    
    @UI: {
           lineItem: [{ position: 100   }]      
       }
    @EndUserText.label: '幣別'       
    documentcurrency,
    @UI: {
           lineItem: [{ position: 110  }]      
       }
    @EndUserText.label: '發票毛額'       
    @Semantics.amount.currencyCode: 'documentcurrency'
    invoicegrossamount,
    @UI: {
           lineItem: [{ position: 120  }]      
       }
    @EndUserText.label: '營業處'       
    businessplace,
    @UI: {
           lineItem: [{ position: 130  }]      
       }
    @EndUserText.label: '付款凍結碼'       
    paymentblockingreason,
    @UI: {
           lineItem: [{ position: 140  }]      
       }
    @EndUserText.label: '到期日計算的基準日期'       
    duecalculationbasedate,
    @UI: {
           lineItem: [{ position: 150  }]      
       }
    @EndUserText.label: '現金折扣金額'       
    @Semantics.amount.currencyCode: 'documentcurrency'     
    manualcashdiscount,
    @UI: {
           lineItem: [{ position: 160  }]      
       }
    @EndUserText.label: '付款方法'       
    paymentmethod,
    @UI: {
           lineItem: [{ position: 170  }]      
       }
    @EndUserText.label: '付款方法補充'       
    paymentmethodsupplement,
    @UI: {
           lineItem: [{ position: 180   }]      
       }
    @EndUserText.label: '付款參考'       
    paymentreference,
    @UI: {
           lineItem: [{ position: 190  }]      
       }
    @EndUserText.label: '發票參考:發票參考文件號碼'       
    invoicereference,
    @UI: {
           lineItem: [{ position: 200   }]      
       }
    @EndUserText.label: '有關發票的會計年度'       
    invoicereferencefiscalyear,
    @UI: {
           lineItem: [{ position: 210   }]      
       }
    @EndUserText.label: '付款條件碼'       
    paymentterms,
    @UI: {
           lineItem: [{ position: 220  }]      
       }
    @EndUserText.label: '現金折扣天數 1'       
    cashdiscount1days,
    @UI: {
           lineItem: [{ position: 230  }]      
       }
    @EndUserText.label: '現金折扣百分比 1'       
    cashdiscount1percent,
    @UI: {
           lineItem: [{ position: 240   }]      
       }
    @EndUserText.label: '現在折扣天數 2'       
    cashdiscount2days,
    @UI: {
           lineItem: [{ position: 250  }]      
       }
    @EndUserText.label: '現金折扣百分比 2'       
    cashdiscount2percent,
    @UI: {
           lineItem: [{ position: 260  }]      
       }
    @EndUserText.label: '淨付款條件期間'       
    netpaymentdays,
    @UI: {
           lineItem: [{ position: 270  }]      
       }
    @EndUserText.label: '固定付款條件'       
    fixedcashdiscount,
    @UI: {
           lineItem: [{ position: 280  }]      
       }
    @EndUserText.label: '未計劃的交貨成本'       
    unplanneddeliverycost,
    @UI: {
           lineItem: [{ position: 290  }]      
       }
    @EndUserText.label: '稅碼'       
    unplanneddeliverycosttaxcode,
    @UI: {
           lineItem: [{ position: 300  }]      
       }
    @EndUserText.label: '租稅管轄權'       
    unplnddelivcosttaxjurisdiction,
    @UI: {
           lineItem: [{ position: 310  }]      
       }
    @EndUserText.label: '參考文件種類'       
    referencedocumentcategory,
    @UI: {
           lineItem: [{ position: 320  }]      
       }
    @EndUserText.label: '指派號碼'       
    assignmentreference2,
    @UI: {
           lineItem: [{ position: 330  }]      
       }
    @EndUserText.label: '項目內文'       
    supplierpostinglineitemtext ,
    @UI: {
           lineItem: [{ position: 340  }]      
       }
    @EndUserText.label: '區段代碼'       
    businesssectioncode ,
    @UI: {
           lineItem: [{ position: 350  }]      
       }
    @EndUserText.label: 'ISR訂戶號碼'       
    paytslipwthrefsubscriber,
    @UI: {
           lineItem: [{ position: 360  }]      
       }
    @EndUserText.label: 'POR檢核碼'       
    paytslipwthrefcheckdigit,
    @UI: {
           lineItem: [{ position: 370  }]      
       }
    @EndUserText.label: '有參考號碼的付款委託書/QR參考號碼'       
    paytslipwthrefreference,
    @UI: {
           lineItem: [{ position: 380  }]      
       }
    @EndUserText.label: '業務範圍'       
    businessarea2,
    @UI: {
           lineItem: [{ position: 390  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'   
    @EndUserText.label: '發票接收日期'       
    invoicereceiptdate,
    @UI: {
           lineItem: [{ position: 400  }]      
       }
    @EndUserText.label: '於歐盟內交貨的申報國家/地區'      
    deliveryofgoodsreportingcntry,
    @UI: {
           lineItem: [{ position: 410  }]      
       }
    @EndUserText.label: '指示碼:歐盟內的三角交易'       
    iseutriangulardeal,
    @UI: {
           lineItem: [{ position: 420  }]      
       }
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZZ1_CL_PREXPORTIV'   
    @EndUserText.label: '定義稅率日期'       
    taxdeterminationdate,
    @UI: {
           lineItem: [{ position: 430  }]      
       }
    @EndUserText.label: '往來銀行的簡短鍵值'       
    housebank,
    @UI: {
           lineItem: [{ position: 440  }]      
       }
    @EndUserText.label: '帳戶明細ID'       
    housebankaccount,
    @UI: {
           lineItem: [{ position: 450  }]      
       }
    @EndUserText.label: '納稅申報國家/地區'       
    unplnddeliverycosttaxcountry,
    @UI: {
           lineItem: [{ position: 460  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 1'       
    jrnlentrycntryspecificref1,
    @UI: {
           lineItem: [{ position: 470   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 1'       
    jrnlentrycntryspecificdate1,
    @UI: {
           lineItem: [{ position: 480  }]      
       }
    @EndUserText.label: '合作銀行類型'       
    bpbankaccountinternalid,
    @UI: {
           lineItem: [{ position: 490  }]      
       }
    @EndUserText.label: '納稅申報日期'       
    taxreportingdate,
    @UI: {
           lineItem: [{ position: 500  }]      
       }
    @EndUserText.label: '稅務執行日期'       
    taxfulfillmentdate,
    @UI: {
           lineItem: [{ position: 510  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定業務夥伴 1'       
    jrnlentrycntryspecificbp1,
    @UI: {
           lineItem: [{ position: 520  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定業務夥伴 2'       
    jrnlentrycntryspecificbp2,
    @UI: {
           lineItem: [{ position: 530   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 2'      
    jrnlentrycntryspecificdate2,
    @UI: {
           lineItem: [{ position: 540   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 3'      
    jrnlentrycntryspecificdate3,
    @UI: {
           lineItem: [{ position: 550   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 4'      
    jrnlentrycntryspecificdate4,
    @UI: {
           lineItem: [{ position: 560   }]      
       }
    @EndUserText.label: '文件中的國家/地區特定日期 5'      
    jrnlentrycntryspecificdate5,
    @UI: {
           lineItem: [{ position: 570  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 2'      
    jrnlentrycntryspecificref2,
    @UI: {
           lineItem: [{ position: 580  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 3'      
    jrnlentrycntryspecificref3,
    @UI: {
           lineItem: [{ position: 590  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 4'      
    jrnlentrycntryspecificref4,
    @UI: {
           lineItem: [{ position: 600  }]      
       }
    @EndUserText.label: '文件中的國家/地區特定參考 5'      
    jrnlentrycntryspecificref5,
    @UI: {
           lineItem: [{ position: 610  }]      
       }
    @EndUserText.label: 'IBAN(國際銀行帳號)'       
    iban,
    @UI: {
           lineItem: [{ position: 620  }]      
       }
    @EndUserText.label: '零星科目資料中的國家/地區特定參考'      
    onetimeacctcntryspecificref1,
    @UI: {
           lineItem: [{ position: 630  }]      
       }
    @EndUserText.label: '付款原因'      
    paymentreason,
    @UI: {
           lineItem: [{ position: 640  }]      
       }
    @EndUserText.label: '發票頁數'      
    numberofpages,
    @UI: {
           lineItem: [{ position: 650  }]      
       }
    @EndUserText.label: '供應國家/地區'      
    supplyingcountry1,
    @UI: {
           lineItem: [{ position: 660  }]      
       }
    @EndUserText.label: '中央銀行指示碼'      
    statecentralbankpaymentreason1,
    @UI: {
           lineItem: [{ position: 661  }]      
       }
    @EndUserText.label: '調節科目'      
    invoicingpartyaccount,    
    @UI: {
           lineItem: [{ position: 670  }]      
       }
    @EndUserText.label: '後勤發票驗證文件的來源'      
    supplierinvoiceorigin,
    @UI: {
           lineItem: [{ position: 680  }]      
       }
    @EndUserText.label: '業務網路文件的來源'      
    businessnetworkorigin,
    @UI: {
           lineItem: [{ position: 690  }]      
       }
    @EndUserText.label: '發票上傳UUID'      
    supplierinvoiceuploadfileuuid,
    @UI: {
           lineItem: [{ position: 700  }]      
       }
    @EndUserText.label: '上傳的發票來源'      
    supplierinvoiceuploadorigin,
    @UI: {
           lineItem: [{ position: 710  }]      
       }
    @EndUserText.label: '公司代碼'      
    companycode,
    @UI: {
           lineItem: [{ position: 720  }]      
       }
    @EndUserText.label: '科目'      
    glaccount,
    @UI: {
           lineItem: [{ position: 730  }]      
       }
    @EndUserText.label: '項目內文'      
    supplierinvoiceitemtext,
    @UI: {
           lineItem: [{ position: 740  }]      
       }
    @EndUserText.label: '借/貸方指示碼'      
    debitcreditcode,
//    @UI: {
//           lineItem: [{ position: 750  }]      
//       }
//    @EndUserText.label: '金額(文件幣別)'      
//    @Semantics.amount.currencyCode: 'documentcurrency'
//    supplierinvoiceitemamount,
    @UI: {
           lineItem: [{ position: 760  }]      
       }
    @EndUserText.label: '稅碼'      
    taxcode, //稅碼    
    @UI: {
           lineItem: [{ position: 770  }]      
       }
    @EndUserText.label: '租稅管轄權'      
    taxjurisdiction,
    @UI: {
           lineItem: [{ position: 780  }]      
       }
    @EndUserText.label: '指派'      
    assignmentreference,
//    @UI: {
//           lineItem: [{ position: 790  }]      
//       }
//    @EndUserText.label: '成本中心'      
//    costcenter,      
    @UI: {
           lineItem: [{ position: 800  }]      
       }
    @EndUserText.label: '利潤中心'      
    profitcenter,
    @UI: {
           lineItem: [{ position: 810  }]      
       }
    @EndUserText.label: '訂單號碼'      
    internalorder,
  
    @UI: {
           lineItem: [{ position: 820  }]      
       }
    @EndUserText.label: 'WBS元素'      
    wbselement   ,    
    @UI: {
           lineItem: [{ position: 830  }]      
       }
    @EndUserText.label: '業務範圍'      
    businessarea,
    @UI: {
           lineItem: [{ position: 840  }]      
       }
    @EndUserText.label: '企業流程'      
    businessprocess,
    @UI: {
           lineItem: [{ position: 850  }]      
       }
    @EndUserText.label: '成本控制範圍'      
    controllingarea,
    @UI: {
           lineItem: [{ position: 860  }]      
       }
    @EndUserText.label: '作業類型'      
    costctractivitytype,
    @UI: {
           lineItem: [{ position: 870  }]      
       }
    @EndUserText.label: '成本物件'      
    costobject,
    @UI: {
           lineItem: [{ position: 880  }]      
       }
    @EndUserText.label: '功能範圍'      
    functionalarea,
    @UI: {
           lineItem: [{ position: 890  }]      
       }
    @EndUserText.label: '沒有現金折扣'      
    isnotcashdiscountliable,
    @UI: {
           lineItem: [{ position: 900  }]      
       }
    @EndUserText.label: '員工號碼'      
    personnelnumber,
    @UI: {
           lineItem: [{ position: 910  }]      
       }
    @EndUserText.label: '銷售訂單號碼'      
    salesorder,
    @UI: {
           lineItem: [{ position: 920  }]      
       }
    @EndUserText.label: '銷售訂單項目'   
    salesorderitem,
    @UI: {
           lineItem: [{ position: 930  }]      
       }
    @EndUserText.label: '科目指派網狀圖號碼'    
    projectnetwork,
    @UI: {
           lineItem: [{ position: 940  }]      
       }
    @EndUserText.label: '作業號碼'    
    networkactivity,
    @UI: {
           lineItem: [{ position: 950  }]      
       }
    @EndUserText.label: '工作項目ID'    
    workitem,
    @UI: {
           lineItem: [{ position: 960  }]      
       }
    @EndUserText.label: '承約項目'    
    commitmentitem,
    @UI: {
           lineItem: [{ position: 970  }]      
       }
    @EndUserText.label: '基金中心'    
    fundsmanagementcenter,
    @UI: {
           lineItem: [{ position: 980  }]      
       }
    @EndUserText.label: '文件貨幣計的稅基金額'    
    taxbaseamountintranscrcy,    
    @UI: {
           lineItem: [{ position: 990   }]      
       }
    @EndUserText.label: '基金'    
    funds,
    @UI: {
           lineItem: [{ position: 1000   }]      
       }
    @EndUserText.label: '贊助金'    
    donate,
    @UI: {
           lineItem: [{ position: 1010   }]      
       }
    @EndUserText.label: '基礎計量單位'    
    quantityunit,
    @UI: {
           lineItem: [{ position: 1020  }]      
       }
    @EndUserText.label: '數量'    
    quantity,
    @UI: {
           lineItem: [{ position: 1030   }]      
       }
    @EndUserText.label: '夥伴業務範圍'    
    partnerbusinessarea,
    @UI: {
           lineItem: [{ position: 1040   }]      
       }
    @EndUserText.label: '服務文件類型'    
    servicedocumenttype,
    @UI: {
           lineItem: [{ position: 1050  }]      
       }
    @EndUserText.label: '服務文件ID'    
    servicedocument,
    @UI: {
           lineItem: [{ position: 1060  }]      
       }
    @EndUserText.label: '服務文件項目ID'    
    servicedocumentitem,
    @UI: {
           lineItem: [{ position: 1070  }]      
       }
    @EndUserText.label: '納稅申報國家/地區'    
    taxcountry,
    @UI: {
           lineItem: [{ position: 1080  }]      
       }
    @EndUserText.label: '交易類型'    
    financialtransactiontype,
    @UI: {
           lineItem: [{ position: 1090  }]      
       }
    @EndUserText.label: '預算期間'    
    budgetperiod,
    @UI: {
           lineItem: [{ position: 1100  }]      
       }
    @EndUserText.label: '已指定用途基金的文件號碼'    
    earmarkedfundsdocument,
    @UI: {
           lineItem: [{ position: 1110  }]      
       }
    @EndUserText.label: '已指定用途的基金:文件項目'    
    earmarkedfundsdocumentitem,
    @UI: {
           lineItem: [{ position: 1120  }]      
       }
    @EndUserText.label: '明細項目的完成指示碼'    
    emrkdfndsitmiscompleted,
    @UI: {
           lineItem: [{ position: 1130  }]      
       }
    @EndUserText.label: '復原指示碼'    
    jointventurerecoverycode,
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
    @UI: {
           lineItem: [{ position: 1140  }]      
       }
    @EndUserText.label: '請購單號'     
    purchaserequisition    ,
    @UI: {
           lineItem: [{ position: 1150  }]      
       }
    @EndUserText.label: '請購單項目'      
    purchaserequisitionitem ,
    @UI: {
           lineItem: [{ position: 1160  }]      
       }
    @EndUserText.label: '訊息'      
    msg    
}
